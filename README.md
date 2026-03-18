# Google Cloud Secure Foundation - Next '26

This repository contains the blueprints, Terraform assets, and reference architectures for the Google Next '26 Secure Foundation demo. Security Foundation provides Google Cloud-aligned guidance and controls for network security, monitoring, data protection, and DevSecOps. 

Explore how to secure your AI, data, and infrastructure with Google Cloud Security Foundation.

---

## Network Security & Threat Protection

This module highlights advanced network defense mechanisms powered by Google Cloud and industry-leading security partners. It demonstrates how to integrate threat protection, intrusion detection, and advanced filtering directly into your cloud network architecture.

**Core Partner Integrations:**
* **Cloud NGFW:** Enhanced with AI/ML protection from Palo Alto Networks (PANW).
* **Cloud IDS:** Intrusion Detection System powered by PANW.
* **DNS Armor:** Advanced DNS Security integrated with Infoblox.
* **Cloud Armor:** Upgraded with new Web Application Firewall (WAF) rules from Imperva.

### Codelabs & Hands-On Innovations

The following codelabs provide step-by-step instructions for implementing these network security controls. 

#### Cloud NGFW
* [Cloud NGFW Enterprise for TLS Inspection](https://codelabs.developers.google.com/cloud-ngfw-enterprise-tls?hl=en#0)
* [Cloud NGFW Enterprise Intrusion Prevention Service](https://codelabs.developers.google.com/cloud-firewall-plus?hl=en#0) (without TLS)
* [Cloud NGFW Enterprise Domain/SNI Filtering](https://codelabs.developers.google.com/cloud-ngfw-enterprise-urlf?hl=en#1)

#### Cloud Armor
* [Getting Started with Cloud Armor’s Advanced Threat Detection](https://codelabs.developers.google.com/dns-armor-getting-started?hl=en#6)
* [Bot Management with Google Cloud Armor + reCAPTCHA](https://codelabs.developers.google.com/codelabs/cloud-armor-recaptcha-bot-management?hl=en#0)
* [Cloud Armor for NLB/VM with User Defined Rules](https://codelabs.developers.google.com/codelabs/ca4nlb-phase2?hl=en#0)

#### DNS Armor
* [Getting Started with DNS Armor’s Advanced Threat Detection](https://codelabs.developers.google.com/dns-armor-getting-started?hl=en#6)
* [Visualizing DNS Armor’s Advanced Threat Detection Logs using Log Based Metrics and Custom Dashboard](https://codelabs.developers.google.com/dns-armor-monitoring-dashboard?hl=en#7)

#### Network Security Integration
* [In-band Network Security Integration](https://codelabs.developers.google.com/network-security-integration-in-band?hl=en#0)

#### VPC Service Control
* [VPC Service Controls - BigQuery Data Transfer Service Protection](https://codelabs.developers.google.com/codelabs/vpc-sc-bigquery-data-transfer?hl=en#0)

---

## Data Protection: The Invisible Data Perimeter

This module provides a high-level architecture for securing massive datasets containing Personally Identifiable Information (PII) against accidental exposure and malicious exfiltration. It highlights how network perimeters explicitly override permissive Identity Access Management (IAM) settings to prevent unauthorized public access, even when resources are misconfigured.

**Key Components:**
* **Cloud Sensitive Data Protection (DLP):** Discovers, classifies, and auto-tags PII across unstructured datasets to establish a risk profile.
* **VPC Service Controls:** Creates the "invisible vault" by establishing a rigid network boundary that blocks external access requests.
* **Cloud KMS Autokey:** Automates the creation, assignment, and rotation of Customer-Managed Encryption Keys (CMEK) to eliminate manual toil.
* **Access Context Manager:** Evaluates the specific context of an access request (such as a trusted device or corporate IP) to permit authorized traffic through the perimeter.
* **BigQuery and Cloud Storage:** The target data repositories containing the sensitive information secured within the restricted service perimeter.

---

## DevSecOps: The Trusted Supply Chain

This module outlines a high-level architecture for establishing a secure software supply chain on Google Cloud. It focuses on preventing the deployment of containerized microservices that contain critical vulnerabilities or hardcoded secrets.

**Key Components:**
* **Cloud Source Repositories:** The secure Git-based version control system where developers commit application code.
* **Cloud Build:** The serverless CI/CD platform that executes the build process, triggers security scans, and handles image signing.
* **Artifact Registry & Artifact Analysis:** The central repository for managing container images, integrated with an automated scanning engine that inspects images for CVEs and provides metadata for attestations.
* **Binary Authorization:** The deploy-time security control that ensures only images signed by trusted attestors can be deployed to GKE or Cloud Run.
* **Secret Manager:** The centralized system for storing and managing sensitive credentials, which are injected into the application at runtime to avoid hardcoded keys.

---

## Agentic Security 

*(Content for this section will be updated later)*

---

## Contributors

| Name | Role | Contact |
| :--- | :--- | :--- |
| **Susan Wu** | Outbound Product Manager | [LinkedIn](https://www.linkedin.com/in/TBD/) |
| **Osvaldo Costa** |  Network CE Specialist | [LinkedIn](https://www.linkedin.com/in/manishkgaur/) |
| **Manish Gaur** | Security Architect | [LinkedIn](https://www.linkedin.com/in/manishkgaur/) |
