# Observability components into Amazon AWS

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/10860/badge)](https://www.bestpractices.dev/en/projects/10860)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/nlamirault/terraform-aws-observability/badge)](https://securityscorecards.dev/viewer/?uri=github.com/nlamirault/terraform-aws-observability)
[![SLSA 3](https://slsa.dev/images/gh-badge-level3.svg)](https://slsa.dev)

This module consists of the following submodules:

- [Prometheus](https://github.com/nlamirault/terraform-aws-observability/tree/master/modules/prometheus)
- [Mimir](https://github.com/nlamirault/terraform-aws-observability/tree/master/modules/mimir)
- [Loki](https://github.com/nlamirault/terraform-aws-observability/tree/master/modules/loki)
- [Tempo](https://github.com/nlamirault/terraform-aws-observability/tree/master/modules/tempo)
- [Grafana](https://github.com/nlamirault/terraform-aws-observability/tree/master/modules/grafana)
- [AWS Managed Service for Prometheus](https://github.com/nlamirault/terraform-aws-observability/tree/master/modules/amp)
- [AWS Managed Grafana](https://github.com/nlamirault/terraform-aws-observability/tree/master/modules/amg)
- [AWS Distro for OpenTelemetry (ADOT) Operator](https://github.com/nlamirault/terraform-aws-observability/tree/master/modules/adot)
- [CloudWatch](https://github.com/nlamirault/terraform-aws-observability/tree/master/modules/cloudwatch)

See more details in each module's README.

## SLSA

All _artifacts_ provided by this repository meet [SLSA L3](https://slsa.dev/spec/v1.0/levels#build-l3)

### Verify SLSA provenance using the Github CLI

```shell
gh attestation verify oci://ghcr.io/nlamirault/modules/terraform-aws-observability:v5.2.0 --repo nlamirault/terraform-aws-observability
Loaded digest sha256:9b3328752958e082cfb0d28bb6c1e466d716f56e8850391a935349013dd90257 for oci://ghcr.io/nlamirault/modules/terraform-aws-observability:v5.2.0
Loaded 1 attestation from GitHub API
✓ Verification succeeded!

sha256:9b3328752958e082cfb0d28bb6c1e466d716f56e8850391a935349013dd90257 was attested by:
REPO                                    PREDICATE_TYPE                  WORKFLOW
nlamirault/terraform-aws-observability  https://slsa.dev/provenance/v1  .github/workflows/oci.yaml@refs/tags/v5.2.0
```

### Verify SLSA provenance using Cosign

```shell
$ cosign verify-attestation \
  --type slsaprovenance \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  --certificate-identity-regexp '^https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v[0-9]+.[0-9]+.[0-9]+$' \
  ghcr.io/nlamirault/modules/terraform-aws-observability:v5.2.0@sha256:9b3328752958e082cfb0d28bb6c1e466d716f56e8850391a935349013dd90257

Verification for ghcr.io/nlamirault/modules/terraform-aws-observability:v5.2.0@sha256:9b3328752958e082cfb0d28bb6c1e466d716f56e8850391a935349013dd90257 --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - The code-signing certificate was verified using trusted certificate authority certificates
Certificate subject: https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v2.1.0
Certificate issuer URL: https://token.actions.githubusercontent.com
GitHub Workflow Trigger: push
GitHub Workflow SHA: 62f76910908f3ada58542638eb201a74c5778e73
GitHub Workflow Name: Terraform / OCI
GitHub Workflow Repository: nlamirault/terraform-aws-observability
GitHub Workflow Ref: refs/tags/v5.2.0
GitHub Workflow Ref: refs/tags/v0.0.4
...
```

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)

## License

[Apache 2.0 License](./LICENSE)
