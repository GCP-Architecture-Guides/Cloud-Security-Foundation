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

# Autokey KeyHandles in project_id (delegated model: keys provisioned in the same project as resources).
# Requires google_kms_autokey_config with key_project_resolution_mode = RESOURCE_PROJECT.

resource "google_kms_key_handle" "bq_secure_data_warehouse" {
  count    = local.autokey_keyhandles_enabled ? 1 : 0
  provider = google-beta

  project                = var.project_id
  name                   = "bq-wh-${random_id.suffix.hex}"
  location               = var.region
  resource_type_selector = "bigquery.googleapis.com/Dataset"

  depends_on = [
    google_kms_autokey_config.autokey,
    google_project_service.required_apis,
  ]
}

resource "google_kms_key_handle" "bq_secops_dashboard" {
  count    = local.autokey_keyhandles_enabled ? 1 : 0
  provider = google-beta

  project                = var.project_id
  name                   = "bq-secops-${random_id.suffix.hex}"
  location               = "us"
  resource_type_selector = "bigquery.googleapis.com/Dataset"

  depends_on = [
    google_kms_autokey_config.autokey,
    google_project_service.required_apis,
  ]
}

resource "google_kms_key_handle" "gcs_raw_ingestion" {
  count    = local.autokey_keyhandles_enabled ? 1 : 0
  provider = google-beta

  project                = var.project_id
  name                   = "gcs-raw-${random_id.suffix.hex}"
  location               = var.region
  resource_type_selector = "storage.googleapis.com/Bucket"

  depends_on = [
    google_kms_autokey_config.autokey,
    google_project_service.required_apis,
  ]
}

resource "google_kms_key_handle" "gcs_public_permissive" {
  count    = local.autokey_keyhandles_enabled ? 1 : 0
  provider = google-beta

  project                = var.project_id
  name                   = "gcs-pub-${random_id.suffix.hex}"
  location               = var.region
  resource_type_selector = "storage.googleapis.com/Bucket"

  depends_on = [
    google_kms_autokey_config.autokey,
    google_project_service.required_apis,
  ]
}

resource "google_kms_crypto_key_iam_member" "autokey_bq_warehouse_decrypter" {
  count = local.autokey_keyhandles_enabled ? 1 : 0

  crypto_key_id = google_kms_key_handle.bq_secure_data_warehouse[0].kms_key
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  member        = "user:${var.allowed_user_identity}"
}

resource "google_kms_crypto_key_iam_member" "autokey_bq_secops_log_sink" {
  count = local.autokey_keyhandles_enabled ? 1 : 0

  crypto_key_id = google_kms_key_handle.bq_secops_dashboard[0].kms_key
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = google_logging_project_sink.vpc_sc_violations.writer_identity

  depends_on = [
    google_logging_project_sink.vpc_sc_violations,
    google_kms_key_handle.bq_secops_dashboard,
  ]
}
