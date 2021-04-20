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

CONFIG_CLUSTER_MEMBERSHIP_NAME_DESCRIPTION="name of the membership to designate as the Config cluster"
GOOGLE_CLOUD_PROJECT_DESCRIPTION="ID of the Google Cloud Project of the Config cluster membership"

usage() {
  echo "${SCRIPT_BASENAME} - This script provisions and configures Multi-Cluster Ingress and Multi-Cluster Services."
  echo
  echo "USAGE"
  echo "  ${SCRIPT_BASENAME} [options]"
  echo
  echo "OPTIONS"
  echo "  -h $(is_linux && echo "| --help"): ${HELP_DESCRIPTION}"
  echo "  -m $(is_linux && echo "| --config-cluster-membership-name"): ${CONFIG_CLUSTER_MEMBERSHIP_NAME_DESCRIPTION}"
  echo "  -p $(is_linux && echo "| --google-cloud-project"): ${GOOGLE_CLOUD_PROJECT_DESCRIPTION}"
  echo
  echo "EXIT STATUS"
  echo
  echo "  $EXIT_OK on correct execution."
  echo "  $ERR_VARIABLE_NOT_DEFINED when a parameter or a variable is not defined, or empty."
  echo "  $ERR_MISSING_DEPENDENCY when a required dependency is missing."
  echo "  $ERR_ARGUMENT_EVAL_ERROR when there was an error while evaluating the program options."
}

LONG_OPTIONS="config-cluster-membership-name:,google-cloud-project:,help,update-config-cluster"
SHORT_OPTIONS="hm:p:u"

echo "Checking if the necessary dependencies are available..."
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
if [ ! $RET_CODE ]; then
  echo "Error while evaluating command options. Terminating..."
  # Ignoring SC2086 because those are defined in common.sh, and don't need quotes
  # shellcheck disable=SC2086
  exit ${ERR_ARGUMENT_EVAL_ERROR}
fi
eval set -- "${TEMP}"

CONFIG_CLUSTER_MEMBERSHIP_NAME=
GOOGLE_CLOUD_PROJECT=

while true; do
  case "${1}" in
  -m | --config-cluster-membership-name)
    CONFIG_CLUSTER_MEMBERSHIP_NAME="${2}"
    shift 2
    ;;
  -p | --google-cloud-project)
    GOOGLE_CLOUD_PROJECT="${2}"
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
    break
    ;;
  esac
done

echo "Checking if the necessary parameters are set..."
check_argument "${CONFIG_CLUSTER_MEMBERSHIP_NAME}" "${CONFIG_CLUSTER_MEMBERSHIP_NAME_DESCRIPTION}"
check_argument "${GOOGLE_CLOUD_PROJECT}" "${GOOGLE_CLOUD_PROJECT_DESCRIPTION}"

echo "Enabling Multi-Cluster Ingress and selecting the ${CONFIG_CLUSTER_MEMBERSHIP_NAME} in the ${GOOGLE_CLOUD_PROJECT} project as the config cluster..."
gcloud alpha container hub ingress enable \
  --config-membership=projects/"${GOOGLE_CLOUD_PROJECT}"/locations/global/memberships/"${CONFIG_CLUSTER_MEMBERSHIP_NAME}"

echo "Enabling Multi-Cluster Services in the ${GOOGLE_CLOUD_PROJECT} project..."
gcloud alpha container hub multi-cluster-services enable \
  --project "${GOOGLE_CLOUD_PROJECT}"
