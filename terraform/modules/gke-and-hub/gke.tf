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

module "kubernetes-engine" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "17.3.0"

  name                     = var.gke_cluster_name
  network                  = var.vpc_name
  ip_range_pods            = var.pods_ip_range_name
  ip_range_services        = var.services_ip_range_name
  project_id               = var.project_id
  region                   = var.region
  release_channel          = var.release_channel
  remove_default_node_pool = var.remove_default_node_pool
  subnetwork               = var.subnetwork_name

  node_pools = [
    {
      auto_repair  = var.auto_repair
      auto_upgrade = var.auto_upgrade
      machine_type = var.machine_type
      name         = "${var.gke_cluster_name}-node-pool"
      node_count   = var.gke_cluster_node_pool_size
    }
  ]

  # Grant the cloud-platform scope, and use IAM to limit access
  # See: https://cloud.google.com/compute/docs/access/service-accounts#associating_a_service_account_to_an_instance
  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
