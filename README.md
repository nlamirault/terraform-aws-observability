# Observability components into Amazon AWS

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/10881/badge)](https://www.bestpractices.dev/en/projects/10881)
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
$ gh attestation verify oci://ghcr.io/nlamirault/modules/terraform-aws-observability:v6.0.0 --repo nlamirault/terraform-aws-observability
Loaded digest sha256:006e0f3fdc4071db667cef0b922de39addbb4996765fb76213cfb1b03cbabf05 for oci://ghcr.io/nlamirault/modules/terraform-aws-observability:v6.0.0
Loaded 1 attestation from GitHub API
✓ Verification succeeded!

sha256:006e0f3fdc4071db667cef0b922de39addbb4996765fb76213cfb1b03cbabf05 was attested by:
REPO                                    PREDICATE_TYPE                  WORKFLOW
nlamirault/terraform-aws-observability  https://slsa.dev/provenance/v1  .github/workflows/oci.yaml@refs/tags/v6.0.0
```

### Verify SLSA provenance using Cosign

```shell
$ cosign verify-attestation \
  --type slsaprovenance \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  --certificate-identity-regexp '^https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v[0-9]+.[0-9]+.[0-9]+$' \
  ghcr.io/nlamirault/modules/terraform-aws-observability:v6.0.0@sha256:006e0f3fdc4071db667cef0b922de39addbb4996765fb76213cfb1b03cbabf05

Verification for ghcr.io/nlamirault/modules/terraform-aws-observability:v6.0.0@sha256:006e0f3fdc4071db667cef0b922de39addbb4996765fb76213cfb1b03cbabf05 --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - The code-signing certificate was verified using trusted certificate authority certificates
Certificate subject: https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v2.1.0
Certificate issuer URL: https://token.actions.githubusercontent.com
GitHub Workflow Trigger: push
GitHub Workflow SHA: 51be5478e6dde0e6f1cf69ae74d2f8c0f63c42f6
GitHub Workflow Name: Terraform / OCI
GitHub Workflow Repository: nlamirault/terraform-aws-observability
GitHub Workflow Ref: refs/tags/v6.0.0
...
```

## OCI

You could discover all the referrers of manifest with annotations, displayed in a tree view:

```shell
$ oras discover --format tree ghcr.io/nlamirault/modules/terraform-aws-observability:v6.0.0
ghcr.io/nlamirault/modules/terraform-aws-observability@sha256:006e0f3fdc4071db667cef0b922de39addbb4996765fb76213cfb1b03cbabf05
└── application/vnd.dev.sigstore.bundle.v0.3+json
    └── sha256:b6b84f1d250eeedeb180ab2d3414ceb32da0f97120f7b088e59dfa2b134c6220
```

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)

## License

[Apache 2.0 License](./LICENSE)
