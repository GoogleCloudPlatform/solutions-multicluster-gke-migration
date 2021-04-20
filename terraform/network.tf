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

resource "google_compute_network" "tutorial-vpc" {
  name                    = "${google_project.tutorial_project.project_id}-vpc"
  auto_create_subnetworks = "false"
  project                 = google_project.tutorial_project.project_id

  depends_on = [
    google_project_service.compute-engine-apis,
  ]
}

locals {
  source_cluster_pods_ip_range_name       = "${local.source_cluster_name}-subnet-pods"
  source_cluster_services_ip_range_name   = "${local.source_cluster_name}-subnet-services"
  target_cluster_1_pods_ip_range_name     = "${local.target_cluster_1_name}-subnet-pods"
  target_cluster_1_services_ip_range_name = "${local.target_cluster_1_name}-subnet-services"
  target_cluster_2_pods_ip_range_name     = "${local.target_cluster_2_name}-subnet-pods"
  target_cluster_2_services_ip_range_name = "${local.target_cluster_2_name}-subnet-services"
}

resource "google_compute_subnetwork" "tutorial-subnet-source-cluster" {
  name          = "${google_project.tutorial_project.project_id}-cluster-subnet"
  region        = var.google_default_region
  network       = google_compute_network.tutorial-vpc.name
  ip_cidr_range = "10.10.0.0/24"
  project       = google_project.tutorial_project.project_id

  secondary_ip_range {
    range_name    = local.source_cluster_pods_ip_range_name
    ip_cidr_range = "192.168.0.0/19"
  }

  secondary_ip_range {
    range_name    = local.source_cluster_services_ip_range_name
    ip_cidr_range = "192.168.32.0/19"
  }

  secondary_ip_range {
    range_name    = local.target_cluster_1_pods_ip_range_name
    ip_cidr_range = "192.168.64.0/19"
  }

  secondary_ip_range {
    range_name    = local.target_cluster_1_services_ip_range_name
    ip_cidr_range = "192.168.96.0/19"
  }

  secondary_ip_range {
    range_name    = local.target_cluster_2_pods_ip_range_name
    ip_cidr_range = "192.168.128.0/19"
  }

  secondary_ip_range {
    range_name    = local.target_cluster_2_services_ip_range_name
    ip_cidr_range = "192.168.160.0/19"
  }

  depends_on = [
    google_project_service.compute-engine-apis,
  ]
}

resource "google_compute_global_address" "example_workload_ingress_global_address" {
  name    = "example-workload-ingress-global-ip"
  project = google_project.tutorial_project.project_id

  depends_on = [
    google_project_service.compute-engine-apis,
  ]
}

resource "google_compute_global_address" "example_workload_multi_cluster_ingress_global_address" {
  name    = "example-workload-multi-cluster-ingress-global-ip"
  project = google_project.tutorial_project.project_id

  depends_on = [
    google_project_service.compute-engine-apis,
  ]
}
