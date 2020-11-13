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

This module creates :


## Documentation
