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

variable "project_id" {
  description = "GCP project ID for the trusted supply chain demo."
  type        = string
}

variable "region" {
  description = "Region for Artifact Registry, KMS key ring, GKE Autopilot, and subnets (e.g. us-central1)."
  type        = string
}

variable "artifact_repository_id" {
  description = "Artifact Registry Docker repository id (images: good-app / bad-app)."
  type        = string
  default     = "secure-supply-chain-repo"
}

variable "gke_cluster_name" {
  description = "GKE Autopilot cluster name."
  type        = string
  default     = "demo-cluster"
}

variable "vpc_name" {
  description = "VPC name used by the GKE Autopilot cluster."
  type        = string
  default     = "demo-gke-vpc"
}

variable "subnet_name" {
  description = "Regional subnet name for GKE (primary + secondary IP ranges)."
  type        = string
  default     = "demo-gke-subnet"
}

variable "environment" {
  description = "Optional label for resources (demo tagging)."
  type        = string
  default     = "demo"
}

variable "kms_keyring_name" {
  description = "Cloud KMS key ring name (Binary Authorization signing key lives here)."
  type        = string
  default     = "binauthz-keyring"
}

variable "kms_crypto_key_name" {
  description = "Asymmetric signing key name used for attestations."
  type        = string
  default     = "binauthz-signing-key"
}

variable "attestor_id" {
  description = "Binary Authorization attestor short name."
  type        = string
  default     = "demo-attestor"
}

variable "container_analysis_note_id" {
  description = "Container Analysis note id (attestation authority)."
  type        = string
  default     = "demo-attestation-note"
}

variable "grant_cloud_build_iam" {
  description = <<-EOT
    When true, grants IAM so `gcloud builds submit` (default worker: Compute Engine default SA) can upload sources,
    push to Artifact Registry, run on-demand scans, sign attestations with KMS, write occurrences, and read db-credentials
    for Cloud Run default runtime. Set false if your org manages these bindings elsewhere.
  EOT
  type        = bool
  default     = true
}
