/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

## NOTE: This provides PoC demo environment for various use cases ##
##  This is not built for production workload ##

# KMS Autokey: delegated (same-project) model when folder_id is set.
#
# key_project_resolution_mode = RESOURCE_PROJECT omits key_project; Autokey creates keys in the
# same project as each protected resource (Preview). Then google_kms_key_handle resources request
# CMEK for BigQuery datasets and GCS buckets in project_id.
# https://cloud.google.com/kms/docs/enable-autokey#delegated_key_management_with_terraform
# https://cloud.google.com/kms/docs/create-resource-with-autokey

locals {
  autokey_folder_enabled     = var.folder_id != null
  autokey_keyhandles_enabled = local.autokey_folder_enabled
}

resource "google_kms_autokey_config" "autokey" {
  count = local.autokey_folder_enabled ? 1 : 0

  folder                      = "folders/${var.folder_id}"
  key_project_resolution_mode = "RESOURCE_PROJECT"

  # Intentionally not gated on the VPC-SC perimeter so Autokey + KeyHandles + BQ seed can run first.
  depends_on = [google_project_service.required_apis]
}

data "google_project" "project" {
  project_id = var.project_id
}
