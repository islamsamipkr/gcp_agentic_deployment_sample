# Validation performed

- Terraform 1.10.5: `terraform fmt -recursive` and `terraform fmt -check -recursive` passed.
- `terraform init -backend=false -input=false` succeeded and installed signed HashiCorp Google provider 7.18.0. Dependency lock file included.
- `terraform validate` was attempted but could not complete: this execution environment denies the Unix socket required to start the provider (`socket: operation not permitted`). This is not a successful provider-schema validation.
- No authenticated plan, apply, container build or live invocation was performed. A real agent image, supported model ID and project configuration are required.

Run `terraform validate` and review `terraform plan` in your own environment before deployment. Review the application contract and production decisions in README.md.
