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

#!/bin/bash
# Local QA: formatting, Terraform validation, optional shellcheck.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "== terraform fmt (check) =="
terraform fmt -check -recursive
echo "OK"

echo "== terraform init =="
terraform init -input=false -no-color
echo "OK"

echo "== terraform validate =="
terraform validate -no-color
echo "OK"

if command -v shellcheck >/dev/null 2>&1; then
  echo "== shellcheck =="
  shellcheck scripts/setup_demo_data.sh scripts/qa.sh
  echo "OK"
else
  echo "== shellcheck (skipped; install shellcheck for script lint) =="
fi

echo "All QA checks passed."
