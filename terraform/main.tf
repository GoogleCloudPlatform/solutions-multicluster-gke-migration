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

provider "google" {
  region = var.google_default_region
  zone   = var.google_default_zone
}

data "google_organization" "main_organization" {
  organization = var.google_organization_id
}

locals {
  google_organization_id = data.google_organization.main_organization.org_id

  source_cluster_name   = "source-cluster-1"
  target_cluster_1_name = "target-cluster-1"
  target_cluster_2_name = "target-cluster-2"
  machine_type          = "e2-standard-2"
  release_channel       = "RAPID"
}

module "gke-and-hub-source" {
  source = "./modules/gke-and-hub"

  auto_repair                = true
  auto_upgrade               = true
  gke_cluster_name           = local.source_cluster_name
  gke_cluster_node_pool_size = var.gke_cluster_node_pool_size
  machine_type               = local.machine_type
  pods_ip_range_name         = local.source_cluster_pods_ip_range_name
  project_id                 = google_project.tutorial_project.project_id
  region                     = var.google_default_region
  release_channel            = local.release_channel
  remove_default_node_pool   = true
  services_ip_range_name     = local.source_cluster_services_ip_range_name
  subnetwork_name            = google_compute_subnetwork.tutorial-subnet-source-cluster.name
  vpc_name                   = google_compute_network.tutorial-vpc.name

  depends_on = [
    google_project_service.anthos-apis,
    google_project_service.cloud-resource-manager-apis,
    google_project_service.compute-engine-apis,
    google_project_service.environ-apis,
    google_project_service.kubernetes-engine-apis,
  ]
}

module "gke-and-hub-target-1" {
  source = "./modules/gke-and-hub"

  auto_repair                = true
  auto_upgrade               = true
  gke_cluster_name           = local.target_cluster_1_name
  gke_cluster_node_pool_size = var.gke_cluster_node_pool_size
  machine_type               = local.machine_type
  pods_ip_range_name         = local.target_cluster_1_pods_ip_range_name
  project_id                 = google_project.tutorial_project.project_id
  region                     = var.google_default_region
  release_channel            = local.release_channel
  remove_default_node_pool   = true
  services_ip_range_name     = local.target_cluster_1_services_ip_range_name
  subnetwork_name            = google_compute_subnetwork.tutorial-subnet-source-cluster.name
  vpc_name                   = google_compute_network.tutorial-vpc.name

  depends_on = [
    google_project_service.anthos-apis,
    google_project_service.cloud-resource-manager-apis,
    google_project_service.compute-engine-apis,
    google_project_service.environ-apis,
    google_project_service.kubernetes-engine-apis,
  ]
}

module "gke-and-hub-target-2" {
  source = "./modules/gke-and-hub"

  auto_repair                = true
  auto_upgrade               = true
  gke_cluster_name           = local.target_cluster_2_name
  gke_cluster_node_pool_size = var.gke_cluster_node_pool_size
  machine_type               = local.machine_type
  pods_ip_range_name         = local.target_cluster_2_pods_ip_range_name
  project_id                 = google_project.tutorial_project.project_id
  region                     = var.google_default_region
  release_channel            = local.release_channel
  remove_default_node_pool   = true
  services_ip_range_name     = local.target_cluster_2_services_ip_range_name
  subnetwork_name            = google_compute_subnetwork.tutorial-subnet-source-cluster.name
  vpc_name                   = google_compute_network.tutorial-vpc.name

  depends_on = [
    google_project_service.anthos-apis,
    google_project_service.cloud-resource-manager-apis,
    google_project_service.compute-engine-apis,
    google_project_service.environ-apis,
    google_project_service.kubernetes-engine-apis,
  ]
}
