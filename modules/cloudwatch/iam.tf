# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

module "irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"
  version = "6.3.0"

  for_each = var.enable_irsa ? toset(["1"]) : toset([])

  name        = local.role_name
  description = "Cloudwatch Agent"

  oidc_providers = {
    main = {
      provider_arn = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
      namespace_service_accounts = [
        ["${var.namespace}:${var.service_account}"]
      ]
    }
  }

  attach_cloudwatch_observability_policy = true

  tags = merge({
    "Name" = local.role_name
  }, var.tags)
}

module "pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "2.0.0"

  for_each = var.enable_pod_identity ? toset(["1"]) : toset([])

  name = local.role_name

  attach_aws_cloudwatch_observability_policy = true

  associations = {
    main = {
      cluster_name    = data.aws_eks_cluster.this.id
      namespace       = var.namespace
      service_account = var.service_account
    }
  }

  tags = merge(
    { "Name" = local.role_name },
    var.tags
  )
}
