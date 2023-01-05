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

GKE_INGRESS_SELECTOR="GKE_INGRESS"
MCI_SELECTOR="MCI"

CONSUME_MCS_DESCRIPTION="Enable the usage of Multi-Cluster Services."
DEPLOY_MCS_DESCRIPTION="Deploy Multi-Cluster Services."
EXPOSE_WITH_DESCRIPTION="What to use to expose workloads outside the cluster. Allowed values: ${GKE_INGRESS_SELECTOR} (expose with GKE Ingress), ${MCI_SELECTOR} (expose with Multi-Cluster Ingress)"
GKE_CLUSTER_NAME_DESCRIPTION="GKE cluster name to deploy workloads to"
GKE_CLUSTER_REGION_DESCRIPTION="ID of the region of the GKE cluster"
GOOGLE_CLOUD_PROJECT_DESCRIPTION="ID of the Google Cloud Project where the cluster to deploy to resides"

usage() {
  echo "${SCRIPT_BASENAME} - This script deploys workloads in the target GKE cluster."
  echo
  echo "USAGE"
  echo "  ${SCRIPT_BASENAME} [options]"
  echo
  echo "OPTIONS"
  echo "  -c $(is_linux && echo "| --consume-mcs"): ${CONSUME_MCS_DESCRIPTION}"
  echo "  -e $(is_linux && echo "| --expose-with"): ${EXPOSE_WITH_DESCRIPTION}"
  echo "  -h $(is_linux && echo "| --help"): ${HELP_DESCRIPTION}"
  echo "  -n $(is_linux && echo "| --cluster-name"): ${GKE_CLUSTER_NAME_DESCRIPTION}"
  echo "  -p $(is_linux && echo "| --google-cloud-project"): ${GOOGLE_CLOUD_PROJECT_DESCRIPTION}"
  echo "  -r $(is_linux && echo "| --cluster-region"): ${GKE_CLUSTER_REGION_DESCRIPTION}"
  echo "  -s $(is_linux && echo "| --deploy-mcs"): ${DEPLOY_MCS_DESCRIPTION}"
  echo
  echo "EXIT STATUS"
  echo
  echo "  ${EXIT_OK} on correct execution."
  echo "  ${ERR_VARIABLE_NOT_DEFINED} when a parameter or a variable is not defined, or empty."
  echo "  ${ERR_MISSING_DEPENDENCY} when a required dependency is missing."
  echo "  ${ERR_ARGUMENT_EVAL_ERROR} when there was an error while evaluating the program options."
}

LONG_OPTIONS="consume-mcs,deploy-mcs,expose-with:,cluster-name:,cluster-region:,google-cloud-project:,help"
SHORT_OPTIONS="ce:hn:p:r:s"

echo "Checking if the necessary dependencies are available..."
check_exec_dependency "envsubst"
check_exec_dependency "gcloud"
check_exec_dependency "getopt"
check_exec_dependency "kubectl"

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

CONSUME_MCS="false"
DEPLOY_MCS="false"
EXPOSE_WITH=
GOOGLE_CLOUD_PROJECT=
GKE_CLUSTER_NAME=
GKE_CLUSTER_REGION=

while true; do
  case "${1}" in
  -c | --consume-mcs)
    CONSUME_MCS="true"
    shift
    ;;
  -e | --expose-with)
    EXPOSE_WITH="${2}"
    shift 2
    ;;
  -n | --cluster-name)
    GKE_CLUSTER_NAME="${2}"
    shift 2
    ;;
  -r | --cluster-region)
    GKE_CLUSTER_REGION="${2}"
    shift 2
    ;;
  -p | --google-cloud-project)
    GOOGLE_CLOUD_PROJECT="${2}"
    shift 2
    ;;
  -s | --deploy-mcs)
    DEPLOY_MCS="true"
    shift
    ;;
  --)
    shift
    break
    ;;
  -h | --help | *)
    usage
    # Ignoring because those are defined in common.sh, and don't need quotes
    # shellcheck disable=SC2086
    exit ${EXIT_OK}
    ;;
  esac
done

echo "Checking if the necessary parameters are set..."
check_argument "${GKE_CLUSTER_NAME}" "${GKE_CLUSTER_NAME_DESCRIPTION}"
check_argument "${GKE_CLUSTER_REGION}" "${GKE_CLUSTER_REGION_DESCRIPTION}"
check_argument "${GOOGLE_CLOUD_PROJECT}" "${GOOGLE_CLOUD_PROJECT_DESCRIPTION}"

echo "Setting the default Google Cloud project to ${GOOGLE_CLOUD_PROJECT}..."
gcloud config set project "${GOOGLE_CLOUD_PROJECT}"

echo "Initializing the GKE cluster credentials for ${GKE_CLUSTER_NAME}..."
gcloud container clusters get-credentials "${GKE_CLUSTER_NAME}" \
  --region="${GKE_CLUSTER_REGION}"

CURRENT_WORKING_DIRECTORY="$(pwd)"
TUTORIAL_KUBERNETES_DESCRIPTORS_PATH="${CURRENT_WORKING_DIRECTORY}"/kubernetes

echo "Deploying workloads to the ${GKE_CLUSTER_NAME} cluster and..."
if [ "${EXPOSE_WITH}" = "${GKE_INGRESS_SELECTOR}" ]; then
  echo "...exposing workloads with ${GKE_INGRESS_SELECTOR}..."
  kubectl apply --kustomize "${TUTORIAL_KUBERNETES_DESCRIPTORS_PATH}"/overlays/ingress
elif [ "${EXPOSE_WITH}" = "${MCI_SELECTOR}" ]; then
  echo "...exposing workloads with ${MCI_SELECTOR}..."
  export GOOGLE_CLOUD_PROJECT
  envsubst < "${TUTORIAL_KUBERNETES_DESCRIPTORS_PATH}"/overlays/mci/bookinfo-mci.yaml.tpl > "${TUTORIAL_KUBERNETES_DESCRIPTORS_PATH}"/overlays/mci/bookinfo-mci.yaml
  kubectl apply --kustomize "${TUTORIAL_KUBERNETES_DESCRIPTORS_PATH}"/overlays/mci
elif [ -n "${EXPOSE_WITH}" ]; then
  echo "ERROR: ${EXPOSE_WITH} doesn't match any of the known values. Terminating..."
  # Ignoring SC2086 because those are defined in common.sh, and don't need quotes
  # shellcheck disable=SC2086
  exit ${ERR_ARGUMENT_EVAL_ERROR}
else
  echo "...the workloads are not going to be exposed outside the ${GKE_CLUSTER_NAME} cluster"
  kubectl apply --kustomize "${TUTORIAL_KUBERNETES_DESCRIPTORS_PATH}"/base
fi

if [ "${DEPLOY_MCS}" = "true" ]; then
  echo "Deploying Multi-Cluster Services in the ${GKE_CLUSTER_NAME} cluster..."
  kubectl apply --kustomize "${TUTORIAL_KUBERNETES_DESCRIPTORS_PATH}"/overlays/mcs
fi

if [ "${CONSUME_MCS}" = "true" ]; then
  echo "Configuring the workloads to use Multi-Cluster Services in the ${GKE_CLUSTER_NAME} cluster..."
  kubectl apply --kustomize "${TUTORIAL_KUBERNETES_DESCRIPTORS_PATH}"/overlays/mcs-environment-variables
fi
