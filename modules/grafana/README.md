# Observability / Grafana

Terraform module which configure Grafana resources on Amazon AWS

## Terraform versions

Use Terraform `0.13` and Terraform Provider Google `3.45+`.

These types of resources are supported:

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

This module creates :


## Documentation

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.14.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cluster\_name | Name of the EKS cluster | `string` | n/a | yes |
| namespace | The Kubernetes namespace | `string` | n/a | yes |
| service\_accounts | The Kubernetes service account | `list(string)` | n/a | yes |
| tags | Tags for grafana | `map(string)` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| role\_arn | n/a |
