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

# Ignoring SC2034 because this variable is used in other scripts
# shellcheck disable=SC2034
EXIT_OK=0
EXIT_GENERIC_ERR=1
ERR_VARIABLE_NOT_DEFINED=2
ERR_MISSING_DEPENDENCY=3
# Ignoring SC2034 because this variable is used in other scripts
# shellcheck disable=SC2034
ERR_ARGUMENT_EVAL_ERROR=4
# Ignoring SC2034 because this variable is used in other scripts
# shellcheck disable=SC2034
ERR_GOOGLE_APPLICATION_CREDENTIALS_NOT_FOUND=5
# Ignoring SC2034 because this variable is used in other scripts
# shellcheck disable=SC2034
ERR_DIRECTORY_NOT_FOUND=6

# Ignoring SC2034 because this variable is used in other scripts
# shellcheck disable=SC2034
HELP_DESCRIPTION="show this help message and exit"

check_argument() {
  ARGUMENT_VALUE="${1}"
  ARGUMENT_DESCRIPTION="${2}"

  if [ -z "${ARGUMENT_VALUE}" ]; then
    echo "[ERROR]: ${ARGUMENT_DESCRIPTION} is not defined. Run this command with the -h option to get help. Terminating..."
    exit ${ERR_VARIABLE_NOT_DEFINED}
  else
    echo "[OK]: ${ARGUMENT_DESCRIPTION} value is defined: ${ARGUMENT_VALUE}"
  fi

  unset ARGUMENT_NAME
  unset ARGUMENT_VALUE
}

check_exec_dependency() {
  EXECUTABLE_NAME="${1}"

  if ! command -v "${EXECUTABLE_NAME}" >/dev/null 2>&1; then
    echo "[ERROR]: ${EXECUTABLE_NAME} command is not available, but it's needed. Make it available in PATH and try again. Terminating..."
    exit ${ERR_MISSING_DEPENDENCY}
  else
    echo "[OK]: ${EXECUTABLE_NAME} is available in PATH, pointing to: $(command -v "${EXECUTABLE_NAME}")"
  fi

  unset EXECUTABLE_NAME
}

create_project_if_necessary() {
  GOOGLE_CLOUD_PROJECT="${1}"
  ORGANIZATION_ID="${2}"
  GOOGLE_CLOUD_BILLING_ACCOUNT_ID="${3}"

  if ! gcloud projects describe "${GOOGLE_CLOUD_PROJECT}" >/dev/null 2>&1; then
    echo "Creating Google Cloud project: ${ORGANIZATION_ID}/${GOOGLE_CLOUD_PROJECT}."
    # [START create_project]
    gcloud projects create "${GOOGLE_CLOUD_PROJECT}" --organization="${ORGANIZATION_ID}"
    # [END create_project]
  fi

  echo "Setting the default Google Cloud project to ${GOOGLE_CLOUD_PROJECT}..."
  gcloud config set project "${GOOGLE_CLOUD_PROJECT}"

  echo "Linking ${GOOGLE_CLOUD_PROJECT} to the ${GOOGLE_CLOUD_BILLING_ACCOUNT_ID} billing ID..."
  # [START set_project_billing]
  gcloud beta billing projects link "${GOOGLE_CLOUD_PROJECT}" --billing-account="${GOOGLE_CLOUD_BILLING_ACCOUNT_ID}"
  # [END set_project_billing]
}

is_linux() {
  os_name="$(uname -s)"
  if test "${os_name#*"Linux"}" != "$os_name"; then
    unset os_name
    return ${EXIT_OK}
  else
    unset os_name
    return ${EXIT_GENERIC_ERR}
  fi
}

is_macos() {
  os_name="$(uname -s)"
  if test "${os_name#*"Darwin"}" != "$os_name"; then
    unset os_name
    return 0
  else
    unset os_name
    return ${EXIT_GENERIC_ERR}
  fi
}
