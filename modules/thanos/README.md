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

This module creates :


## Documentation
