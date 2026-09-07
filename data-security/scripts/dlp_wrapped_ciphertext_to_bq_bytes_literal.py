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

#!/usr/bin/env python3
# Read JSON on stdin: {"ciphertext": "<base64 from google_kms_secret_ciphertext>"}
# Write JSON: {"bq_bytes_literal": "b'\\x..\\x..'"} for DLP_KEY_CHAIN(arg2) in BigQuery views.
import base64
import json
import sys


def main() -> None:
    payload = json.load(sys.stdin)
    raw = base64.b64decode(payload["ciphertext"], validate=True)
    inner = "".join("\\x%02x" % b for b in raw)
    json.dump({"bq_bytes_literal": "b'" + inner + "'"}, sys.stdout)


if __name__ == "__main__":
    main()
