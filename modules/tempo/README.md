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

This module creates :


## Documentation
