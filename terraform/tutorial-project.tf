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

resource "google_project" "tutorial_project" {
  auto_create_network = false
  billing_account     = var.google_billing_account_id
  name                = var.google_default_project_id
  project_id          = var.google_default_project_id
  org_id              = local.google_organization_id
}

resource "google_project_service" "compute-engine-apis" {
  disable_on_destroy = true
  project            = google_project.tutorial_project.project_id
  service            = "compute.googleapis.com"
}

resource "google_project_service" "kubernetes-engine-apis" {
  disable_on_destroy = true
  project            = google_project.tutorial_project.project_id
  service            = "container.googleapis.com"

  depends_on = [
    google_project_service.compute-engine-apis
  ]
}

resource "google_project_service" "anthos-apis" {
  disable_on_destroy = true
  project            = google_project.tutorial_project.project_id
  service            = "anthos.googleapis.com"

  depends_on = [
    google_project_service.environ-apis,
    google_project_service.kubernetes-engine-apis
  ]
}

resource "google_project_service" "cloud-resource-manager-apis" {
  disable_on_destroy = true
  project            = google_project.tutorial_project.project_id
  service            = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "dns-apis" {
  disable_on_destroy = true
  project            = google_project.tutorial_project.project_id
  service            = "dns.googleapis.com"
}

resource "google_project_service" "environ-apis" {
  # Needed to break a circular dependency. gkehub.googleapis.com depends on gkeconnect.googleapis.com
  # and gkeconnect.googleapis.com depends on gkehub.googleapis.com
  disable_dependent_services = true
  disable_on_destroy         = true
  project                    = google_project.tutorial_project.project_id
  service                    = "gkehub.googleapis.com"

  depends_on = [
    google_project_service.gke-connect-apis
  ]
}

resource "google_project_service" "gke-connect-apis" {
  # Needed to break a circular dependency. gkehub.googleapis.com depends on gkeconnect.googleapis.com
  # and gkeconnect.googleapis.com depends on gkehub.googleapis.com
  disable_dependent_services = true
  disable_on_destroy         = true
  project                    = google_project.tutorial_project.project_id
  service                    = "gkeconnect.googleapis.com"
}

resource "google_project_service" "multiclusteringress-apis" {
  disable_on_destroy = true
  project            = google_project.tutorial_project.project_id
  service            = "multiclusteringress.googleapis.com"
}

resource "google_project_service" "multicluster-service-discovery-apis" {
  disable_on_destroy = true
  project            = google_project.tutorial_project.project_id
  service            = "multiclusterservicediscovery.googleapis.com"
}

resource "google_project_service" "trafficdirector-apis" {
  disable_on_destroy = true
  project            = google_project.tutorial_project.project_id
  service            = "trafficdirector.googleapis.com"
}

resource "google_project_iam_member" "compute-network-viewer" {
  member  = "serviceAccount:${google_project.tutorial_project.project_id}.svc.id.goog[gke-mcs/gke-mcs-importer]"
  project = google_project.tutorial_project.project_id
  role    = "roles/compute.networkViewer"

  depends_on = [
    module.gke-and-hub-source,
    module.gke-and-hub-target-1,
    module.gke-and-hub-target-2
  ]
}
