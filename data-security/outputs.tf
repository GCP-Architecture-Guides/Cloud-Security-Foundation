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

output "project_id" {
  description = "The GCP Project ID"
  value       = data.google_project.project.project_id
}

output "raw_ingestion_bucket" {
  description = "The name of the raw ingestion bucket for DLP"
  value       = google_storage_bucket.raw_ingestion.name
}

output "public_permissive_bucket" {
  description = "The name of the intentionally public bucket"
  value       = google_storage_bucket.public_permissive.name
}

output "bigquery_dataset_id" {
  description = "The BigQuery dataset ID"
  value       = google_bigquery_dataset.secure_data_warehouse.dataset_id
}

output "bigquery_dlp_tokenized_view" {
  description = "Saved view that tokenizes SSN and credit_card via BigQuery DLP_DETERMINISTIC_ENCRYPT (run SELECT * in the console; no SQL to paste)"
  value       = "${var.project_id}.${google_bigquery_dataset.secure_data_warehouse.dataset_id}.${google_bigquery_table.pii_dlp_tokenized.table_id}"
}

output "kms_dlp_tokenization_key" {
  description = "Cloud KMS key used by DLP_KEY_CHAIN in the pii_dlp_tokenized view (same region as BigQuery)"
  value       = google_kms_crypto_key.dlp_bq.id
}

output "enable_public_exposure_demo" {
  description = "Whether intentional public bucket IAM, org policy relaxation, and anonymous US/CA access level were applied"
  value       = var.enable_public_exposure_demo
}
