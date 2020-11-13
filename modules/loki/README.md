# Observability / Thanos

Terraform module which configure Thanos resources on Amazon AWS

## Terraform versions

Use Terraform `0.13` and Terraform Provider Google `3.45+`.

These types of resources are supported:

## Usage

```hcl
module "loki" {
  source  = "nlamirault/observability/aws//modules/loki"
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
service_accounts = "loki"]

tags = {
    "project" = "foo"
    "env"     = "staging"
    "service" = "loki"
    "made-by" = "terraform"
}
```

This module creates :


## Documentation
