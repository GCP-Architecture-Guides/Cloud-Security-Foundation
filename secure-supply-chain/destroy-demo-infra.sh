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
# Full Terraform teardown for the Trusted Supply Chain PoC (GKE, KMS, BinAuthz policy, AR repo, etc.).
# Run from the directory that contains main.tf. This is DESTRUCTIVE.
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

if [[ ! -f main.tf ]]; then
  echo -e "${RED}Error: main.tf not found in ${SCRIPT_DIR}${NC}"
  exit 1
fi

echo -e "${RED}${BOLD}DANGER:${NC} ${RED}This runs ${BOLD}terraform destroy${NC}${RED} in:${NC} ${SCRIPT_DIR}"
echo "This removes GKE Autopilot, VPC, Artifact Registry repo, KMS keys, Binary Authorization policy, secrets, and IAM bindings managed by Terraform."
echo ""
read -r -p "Type ${BOLD}destroy${NC} in ALL CAPS to confirm: " ans
if [[ "${ans}" != "DESTROY" ]]; then
  echo -e "${YELLOW}Aborted. No terraform destroy run.${NC}"
  exit 1
fi

echo ""
read -r -p "Second confirmation: destroy ALL Terraform-managed resources in this project? [y/N] " ans2
case "${ans2}" in
  y|Y|yes|YES) ;;
  *)
    echo -e "${YELLOW}Aborted.${NC}"
    exit 1
    ;;
esac

echo -e "${YELLOW}Running terraform destroy...${NC}"
terraform destroy -auto-approve

echo -e "${GREEN}${BOLD}Terraform destroy finished.${NC} Verify in GCP Console that resources are gone."
