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

import csv
import random
import sys

def main():
    # Default to 100 rows to ensure we have a solid block of varied data
    num_rows = 100
    if len(sys.argv) > 1:
        num_rows = int(sys.argv[1])
        
    output_file = "sample_pii_data.txt"
    
    first_names = ["John", "Jane", "Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", "Heidi", "Ivan", "Judy", "Mallory", "Peggy"]
    last_names = ["Smith", "Doe", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez"]
    domains = ["example.com", "test.org", "demo.net", "sample.co", "altostrat.com"]

    print(f"Generating {num_rows} rows of dummy PII data to {output_file}...")

    with open(output_file, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(["id", "first_name", "last_name", "email", "ssn", "credit_card"])

        for i in range(1, num_rows + 1):
            fname = random.choice(first_names)
            lname = random.choice(last_names)
            email = f"{fname.lower()}.{lname.lower()}{random.randint(1,999)}@{random.choice(domains)}"
            
            # Generate fake SSN: AAA-GG-SSSS with distinct blocks
            ssn = f"{random.randint(101, 899):03d}-{random.randint(11, 99):02d}-{random.randint(1001, 9999):04d}"
            
            # Generate fake CC: 16 digits across major card bands (Visa 4, Mastercard 5, Discover 6)
            card_prefix = random.choice([4000, 5100, 5500, 6011])
            cc = f"{card_prefix}-{random.randint(1000, 9999):04d}-{random.randint(1000, 9999):04d}-{random.randint(1000, 9999):04d}"
            
            writer.writerow([i, fname, lname, email, ssn, cc])

    print("Data generation complete.")

if __name__ == "__main__":
    main()
