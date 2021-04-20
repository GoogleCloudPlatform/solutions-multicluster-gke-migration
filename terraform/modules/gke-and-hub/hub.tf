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

# We use the google_gke_hub_membership resource instead of the terraform-google-modules/kubernetes-engine/google//modules/hub module
# because that module doesn't yet support (in version 14.3.0) registering
# clusters with the google_gke_hub_membership resource. Additionally, it introduces
# hard dependencies on the gcloud SDK and bash.
# See: https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/issues/860
resource "google_gke_hub_membership" "source-cluster-hub-membership" {
  membership_id = "${module.kubernetes-engine.location}-${module.kubernetes-engine.name}"
  project       = var.project_id
  provider      = google-beta

  authority {
    issuer = "https://container.googleapis.com/v1/${module.kubernetes-engine.cluster_id}"
  }

  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${module.kubernetes-engine.cluster_id}"
    }
  }
}
