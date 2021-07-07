# Observability / Grafana

Terraform module which configure Grafana resources on Amazon AWS

## Usage

```hcl
module "Grafana" {
  source  = "nlamirault/observability/aws//modules/Grafana"
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
service_accounts = "grafana"

tags = {
    "project" = "foo"
    "env"     = "staging"
    "service" = "grafana"
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
| [aws_secretsmanager_secret](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/data-sources/secretsmanager_secret) |
| [aws_secretsmanager_secret_version](https://registry.terraform.io/providers/hashicorp/aws/3.14.0/docs/data-sources/secretsmanager_secret_version) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Name of the EKS cluster | `string` | n/a | yes |
| namespace | The Kubernetes namespace | `string` | n/a | yes |
| service\_account | The Kubernetes service account | `string` | n/a | yes |
| tags | Tags for grafana | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| role\_arn | Amazon Resource Name for Grafana |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
