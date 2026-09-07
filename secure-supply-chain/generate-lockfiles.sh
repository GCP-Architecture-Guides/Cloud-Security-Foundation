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
# Create package-lock.json in bad-app/ and good-app/ for reproducible Docker builds (npm ci).
# Requires Node/npm locally, or Docker with the node:18 image.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run_in_dir() {
  local dir="$1"
  if command -v npm >/dev/null 2>&1; then
    (cd "${ROOT}/${dir}" && npm install --package-lock-only)
  elif command -v docker >/dev/null 2>&1; then
    docker run --rm -v "${ROOT}/${dir}:/app" -w /app node:18 npm install --package-lock-only
  else
    echo "Install Node.js (npm) or Docker, then re-run this script."
    exit 1
  fi
}

run_in_dir bad-app
run_in_dir good-app
echo "Lockfiles updated under bad-app/ and good-app/."
