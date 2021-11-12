# Observability / Thanos

Terraform module which configure Thanos resources on Amazon AWS

## Terraform versions

Use Terraform `0.13` and Terraform Provider Google `3.45+`.

These types of resources are supported:

## Usage

```hcl
module "thanos" {
  source  = "nlamirault/observability/aws//modules/thanos"
  version = "0.0.0"

  cluster_name = var.cluster_name

  namespace        = var.namespace
  service_accounts = var.service_accounts

  tags = var.tags
}
```

and variables :

```hcl
cluster_name = "foo-staging-eks"

namespace        = "monitoring"
service_accounts = ["thanos-store", "thanos-query", "thanos-compact", "thanos-sidecar"]

tags = {
    "project" = "foo"
    "env"     = "staging"
    "service" = "thanos"
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
| thanos | terraform-aws-modules/s3-bucket/aws | 2.11.1 |
| thanos_log | terraform-aws-modules/s3-bucket/aws | 2.11.1 |
| thanos_role | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |

## Resources

| Name |
|------|
| [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/resources/iam_policy) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/data-sources/iam_policy_document) |
| [aws_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/resources/kms_alias) |
| [aws_kms_key](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/resources/kms_key) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Name of the EKS cluster | `string` | n/a | yes |
| deletion\_window\_in\_days | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days | `number` | `30` | no |
| enable\_kms | Enable custom KMS key | `bool` | n/a | yes |
| namespace | The Kubernetes namespace | `string` | n/a | yes |
| service\_accounts | The Kubernetes service account | `list(string)` | n/a | yes |
| tags | Tags for Thanos | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket | S3 bucket for Thanos |
| role\_arn | Amazon Resource Name for Thanos |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
