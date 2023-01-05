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

variable "gke_cluster_node_pool_size" {
  default     = 1
  description = "Number of nodes GKE cluster node pools."
  type        = number
}

variable "google_billing_account_id" {
  description = "The default billing account for Google Cloud projects."
  type        = string
}

variable "google_default_region" {
  description = "The default Google Cloud region."
  type        = string
}

variable "google_default_zone" {
  description = "The default Google Cloud zone."
  type        = string
}

variable "google_default_project_id" {
  description = "Google Cloud default project ID."
  type        = string
}

variable "google_organization_id" {
  description = "The default organization ID for Google Cloud projects."
  type        = string
}

variable "terraform_environment_name" {
  description = "Name of the current environment."
  type        = string
}
