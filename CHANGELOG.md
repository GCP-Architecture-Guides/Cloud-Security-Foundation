# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- **Native OS Config Policies**: Replaced `null_resource` local-exec scripts with native `google_os_config_os_policy_assignment` resources for CentOS, Debian, and RHEL servers.
- **Native IDS configuration**: Replaced `null_resource` bash scripts with the native `google_ids_endpoint` and `google_compute_packet_mirroring` resources in the `ids-module`.
- **Copyright Headers**: Integrated standard Apache 2.0 open-source copyright headers across all configuration files.
- **Documentation**: Added comprehensive `README.md` containing architectural overview and standard deployment instructions.

### Changed
- **Sanitization**: Removed hardcoded internal Google Cloud project identifiers and IPs in favor of universal placeholder variables (e.g. `YOUR_PROJECT_ID`).
- **Formatting**: Processed the entire repository with `terraform fmt` to ensure compliance with HCL canonical formatting.

### Removed
- Removed legacy container image push tasks (`docker push`) from Terraform definitions in the `appmod-module`. Container builds should be orchestrated by dedicated CI/CD pipelines (e.g. Cloud Build) rather than within the infrastructure baseline.
