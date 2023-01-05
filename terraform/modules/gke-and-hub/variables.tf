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

variable "auto_repair" {
  type = bool
}
variable "auto_upgrade" {
  type = bool
}
variable "gke_cluster_name" {
  type = string
}
variable "gke_cluster_node_pool_size" {
  type = number
}
variable "machine_type" {
  type = string
}
variable "pods_ip_range_name" {
  type = string
}
variable "project_id" {
  type = string
}
variable "region" {
  type = string
}
variable "release_channel" {
  type = string
}
variable "remove_default_node_pool" {
  type = bool
}
variable "services_ip_range_name" {
  type = string
}
variable "subnetwork_name" {
  type = string
}
variable "vpc_name" {
  type = string
}
