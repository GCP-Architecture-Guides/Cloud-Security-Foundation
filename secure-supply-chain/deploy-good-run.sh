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

#!/usr/bin/env bash
# Deploy good-app to Cloud Run with DB_PASSWORD from Secret Manager (secret: db-credentials).
#
# Required environment variables:
#   PROJECT_ID  — your GCP project (conceptually <YOUR_PROJECT_ID>)
#   REGION      — Cloud Run / Artifact Registry region (conceptually <YOUR_REGION>)
#   TAG         — image tag or Cloud Build BUILD_ID for good-app
#
# Optional: REPO_NAME (default secure-supply-chain-repo), SERVICE_NAME (default trusted-good-app)
#
# Example:
#   export PROJECT_ID="<YOUR_PROJECT_ID>"
#   export REGION="<YOUR_REGION>"
#   export TAG="<YOUR_BUILD_ID>"
#   ./deploy-good-run.sh
#
# Or: cp .env.example .env  # edit values, then:
#   set -a && source .env && set +a && ./deploy-good-run.sh
set -euo pipefail

: "${PROJECT_ID:?Set PROJECT_ID to your GCP project id}"
: "${REGION:?Set REGION (e.g. us-central1)}"
: "${TAG:?Set TAG to your good-app image tag or Cloud Build BUILD_ID}"

REPO_NAME="${REPO_NAME:-secure-supply-chain-repo}"
SERVICE_NAME="${SERVICE_NAME:-trusted-good-app}"

IMAGE="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/good-app:${TAG}"

gcloud run deploy "${SERVICE_NAME}" \
  --project="${PROJECT_ID}" \
  --region="${REGION}" \
  --image="${IMAGE}" \
  --port=3000 \
  --set-secrets="DB_PASSWORD=db-credentials:latest" \
  --allow-unauthenticated \
  --quiet

echo "Deployed ${SERVICE_NAME} using image ${IMAGE}"
