# Observability / Prometheus

Terraform module which configure Prometheus resources on Amazon AWS

## Terraform versions

Use Terraform `0.13` and Terraform Provider Google `3.45+`.

These types of resources are supported:

## Usage

```hcl
module "prometheus" {
  source  = "nlamirault/observability/aws//modules/prometheus"
  version = "0.0.0"

  cluster_name = var.cluster_name

  namespace        = var.namespace
  service_accounts = var.service_accounts
  bucket_name      = var.bucket_name

  tags = var.tags
}
```

and variables :

```hcl
cluster_name = "foo-staging-eks"

namespace        = "monitoring"
service_accounts = "prometheus"

bucket_name = "foo-staging-eks-thanos"

tags = {
    "project" = "foo"
    "env"     = "staging"
    "service" = "prometheus"
    "made-by" = "terraform"
}
```

## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 3.14.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| prometheus_role | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |

## Resources

| Name |
|------|
| [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/resources/iam_policy) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/data-sources/iam_policy_document) |
| [aws_kms_key](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/data-sources/kms_key) |
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/data-sources/s3_bucket) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_name | Name of the Thanos bucket | `string` | n/a | yes |
| cluster\_name | Name of the EKS cluster | `string` | n/a | yes |
| enable\_kms | Enable custom KMS key | `bool` | n/a | yes |
| namespace | The Kubernetes namespace | `string` | n/a | yes |
| service\_account | The Kubernetes service account | `string` | n/a | yes |
| tags | Tags for Loki | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| role\_arn | Amazon Resource Name for Prometheus |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
