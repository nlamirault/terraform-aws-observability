# Observability / Tempo

Terraform module which configure Tempo resources on Amazon AWS

## Terraform versions

Use Terraform `0.13` and Terraform Provider Google `3.45+`.

These types of resources are supported:

## Usage

```hcl
module "tempo" {
  source  = "nlamirault/observability/aws//modules/tempo"
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
service_accounts = ["tempo-store", "tempo-query", "tempo-compact"]

tags = {
    "project" = "foo"
    "env"     = "staging"
    "service" = "tempo"
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

No Modules.

## Resources

| Name |
|------|
| [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/resources/iam_policy) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/resources/iam_role) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/resources/iam_role_policy_attachment) |
| [aws_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/resources/kms_alias) |
| [aws_kms_key](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/resources/kms_key) |
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/resources/s3_bucket) |
| [aws_secretsmanager_secret](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/data-sources/secretsmanager_secret) |
| [aws_secretsmanager_secret_version](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/data-sources/secretsmanager_secret_version) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Name of the EKS cluster | `string` | n/a | yes |
| deletion\_window\_in\_days | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days | `number` | `30` | no |
| namespace | The Kubernetes namespace | `string` | n/a | yes |
| service\_account | The Kubernetes service account | `string` | n/a | yes |
| tags | Tags for Loki | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| kms\_arn | Amazon Resource Name for Tempo KMS key |
| role\_arn | Amazon Resource Name for Tempo |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
