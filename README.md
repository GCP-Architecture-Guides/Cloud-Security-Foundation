# Cloud Security Foundation

**Cloud Security Foundation** is a comprehensive Proof of Concept (PoC) demonstration environment for deploying and configuring essential Google Cloud security services. This repository provides Infrastructure as Code (IaC) using Terraform to automatically spin up resources, apply policies, and establish a baseline secure posture.

> [!WARNING]
> **NOTE:** This provides a PoC demo environment for various use cases. This is NOT built for production workloads and should be used strictly for demonstration, learning, and testing purposes.

## Repository Overview

This framework deploys multiple modules that highlight different domains of Google Cloud security:

* **`appmod-module`**: Demonstrates application modernization security, including GKE clusters, Artifact Registry, and KMS integration for signing and encrypting containers.
* **`dlp-vpcsc-module`**: Configures Cloud Data Loss Prevention (DLP) and VPC Service Controls (VPC-SC) to protect sensitive data and mitigate data exfiltration risks.
* **`ids-module`**: Sets up Cloud IDS (Intrusion Detection System) endpoints and packet mirroring to detect network-based threats.
* **`data-security` / `sm-sql-run.tf`**: Secures data layers including Cloud SQL with Secret Manager integration.
* **`OSPolicyAssignments`**: Applies native Google OS Config policies across diverse operating systems (CentOS, Debian, RHEL) for unified endpoint management and compliance.
* **`secure-supply-chain`**: Establishes safeguards for secure software delivery.

## Prerequisites

* [Terraform](https://www.terraform.io/downloads.html) >= 1.3.0
* [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/docs/install)
* A Google Cloud Project with billing enabled
* Necessary IAM permissions (Owner or Editor + Security Admin)

## How to Deploy

1. **Clone the repository:**
   ```bash
   git clone https://github.com/GCP-Architecture-Guides/Cloud-Security-Foundation.git
   cd Cloud-Security-Foundation
   ```

2. **Configure your variables:**
   Update the `terraform.tfvars` file or export your project specific variables.
   ```bash
   export TF_VAR_demo_project_id="YOUR_PROJECT_ID"
   ```

3. **Initialize Terraform:**
   This command downloads the necessary Google Cloud providers.
   ```bash
   terraform init
   ```

4. **Plan the Deployment:**
   Review the resources that will be created.
   ```bash
   terraform plan
   ```

5. **Apply the Infrastructure:**
   Deploy the security foundation. This may take several minutes as services like Cloud SQL, GKE, and IDS endpoints are provisioned.
   ```bash
   terraform apply
   ```

## Clean Up

To avoid incurring ongoing charges, destroy the PoC environment when you are finished:
```bash
terraform destroy
```

## Recent Modernizations

* **Native Resource Adoption**: Legacy local-exec scripts (`null_resource`) have been replaced with native Terraform blocks (e.g., `google_os_config_os_policy_assignment`, `google_ids_endpoint`).
* **Format & Linting**: Enforced canonical HCL formatting and modernized provider constraints.
* **Sanitization**: Removed hardcoded internal identifiers for safe public open-source distribution.

---
*Copyright 2023 Google LLC. Licensed under the Apache License, Version 2.0.*
