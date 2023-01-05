#!/usr/bin/env sh

# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o nounset
set -o errexit

# shellcheck disable=SC1091
. scripts/common.sh

# Doesn't follow symlinks, but it's likely expected for most users
SCRIPT_BASENAME="$(basename "${0}")"

GKE_CLUSTER_REGION_DESCRIPTION="ID of the region of the GKE clusters"
GOOGLE_CLOUD_PROJECT_DESCRIPTION="ID of the Google Cloud Project where the clusters reside"
TERRAFORM_STATE_PROJECT_DESCRIPTION="name of the Google Cloud Project to store the Terraform state"

usage() {
  echo "${SCRIPT_BASENAME} - This script cleans the environment."
  echo
  echo "USAGE"
  echo "  ${SCRIPT_BASENAME} [options]"
  echo
  echo "OPTIONS"
  echo "  -h $(is_linux && echo "| --help"): ${HELP_DESCRIPTION}"
  echo "  -p $(is_linux && echo "| --google-cloud-project"): ${GOOGLE_CLOUD_PROJECT_DESCRIPTION}"
  echo "  -r $(is_linux && echo "| --cluster-region"): ${GKE_CLUSTER_REGION_DESCRIPTION}"
  echo "  -s $(is_linux && echo "| --terraform-state-project"): ${TERRAFORM_STATE_PROJECT_DESCRIPTION}"
  echo
  echo "EXIT STATUS"
  echo
  echo "  ${EXIT_OK} on correct execution."
  echo "  ${ERR_VARIABLE_NOT_DEFINED} when a parameter or a variable is not defined, or empty."
  echo "  ${ERR_MISSING_DEPENDENCY} when a required dependency is missing."
  echo "  ${ERR_ARGUMENT_EVAL_ERROR} when there was an error while evaluating the program options."
}

LONG_OPTIONS="cluster-region:,google-cloud-project:,help,terraform-state-project:"
SHORT_OPTIONS="hp:r:s:"

# BSD getopt (bundled in MacOS) doesn't support long options, and has different parameters than GNU getopt
if is_linux; then
  TEMP="$(getopt -o "${SHORT_OPTIONS}" --long "${LONG_OPTIONS}" -n "${SCRIPT_BASENAME}" -- "$@")"
elif is_macos; then
  TEMP="$(getopt "${SHORT_OPTIONS} --" "$@")"
fi
RET_CODE=$?
if [ ! ${RET_CODE} ]; then
  echo "Error while evaluating command options. Terminating..."
  # Ignoring SC2086 because those are defined in common.sh, and don't need quotes
  # shellcheck disable=SC2086
  exit ${ERR_ARGUMENT_EVAL_ERROR}
fi
eval set -- "${TEMP}"

GKE_CLUSTER_REGION=
GOOGLE_CLOUD_PROJECT=
TERRAFORM_STATE_PROJECT=

while true; do
  case "${1}" in
  -p | --google-cloud-project)
    GOOGLE_CLOUD_PROJECT="${2}"
    shift 2
    ;;
  -r | --cluster-region)
    GKE_CLUSTER_REGION="${2}"
    shift 2
    ;;
  -s | --terraform-state-project)
    TERRAFORM_STATE_PROJECT="${2}"
    shift 2
    ;;
  --)
    shift
    break
    ;;
  -h | --help | *)
    usage
    # Ignoring because those are defined in common.sh, and don't need quotes
    # shellcheck disable=SC2086
    exit $EXIT_OK
    ;;
  esac
done

delete_example_workload() {
  CLUSTER_NAME="${1-}"
  CLUSTER_REGION="${2-}"
  CLUSTER_PROJECT="${3-}"

  check_argument "${CLUSTER_NAME}" "Cluster name"
  check_argument "${CLUSTER_REGION}" "Cluster region"
  check_argument "${CLUSTER_PROJECT}" "Cluster project"

  gcloud container clusters get-credentials "${CLUSTER_NAME}" --region="${CLUSTER_REGION}"
  kubectl delete namespace bookinfo --wait
  gcloud container hub memberships unregister \
    "${GKE_CLUSTER_REGION}-${CLUSTER_NAME}" \
    --project="${CLUSTER_PROJECT}" \
    --gke-cluster="${CLUSTER_REGION}"/"${CLUSTER_NAME}"
}

echo "Checking if the necessary dependencies are available..."
check_exec_dependency "curl"
check_exec_dependency "gcloud"
check_exec_dependency "kubectl"
check_exec_dependency "terraform"

echo "Checking if the necessary parameters are set..."
check_argument "${GKE_CLUSTER_REGION}" "${GKE_CLUSTER_REGION_DESCRIPTION}"
check_argument "${TERRAFORM_STATE_PROJECT}" "${TERRAFORM_STATE_PROJECT_DESCRIPTION}"
check_argument "${GOOGLE_CLOUD_PROJECT}" "${GOOGLE_CLOUD_PROJECT_DESCRIPTION}"

delete_example_workload "target-cluster-2" "${GKE_CLUSTER_REGION}" "${GOOGLE_CLOUD_PROJECT}"
delete_example_workload "target-cluster-1" "${GKE_CLUSTER_REGION}" "${GOOGLE_CLOUD_PROJECT}"

echo "Disabling Environ-level features..."
gcloud alpha container hub ingress disable
gcloud alpha container hub multi-cluster-services disable --project "${GOOGLE_CLOUD_PROJECT}"
curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -X "DELETE" \
  https://gkehub.googleapis.com/v1alpha1/projects/"${CLUSTER_PROJECT}"/locations/global/features/authorizer
curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -X "DELETE" \
  https://gkehub.googleapis.com/v1alpha1/projects/"${CLUSTER_PROJECT}"/locations/global/features/metering

TERRAFORM_ENVIRONMENT_DIR="$(pwd)/terraform"
echo "Changing the working directory to ${TERRAFORM_ENVIRONMENT_DIR}..."
cd "${TERRAFORM_ENVIRONMENT_DIR}"

echo "Deleting resources with Terraform..."
terraform destroy -auto-approve

echo "Deleting bucket where Terraform stores its state information..."
gsutil -m rm -r gs://"${TERRAFORM_STATE_PROJECT}-terraform-state"

echo "Deleting bucket where Terraform stores its state information..."
gcloud projects delete \
  "${TERRAFORM_STATE_PROJECT}" \
  --quiet
