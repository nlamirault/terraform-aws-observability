# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

resource "aws_iam_policy" "bucket" {
  name        = format("%s-bucket", local.service_name)
  path        = "/"
  description = "Bucket permissions for Mimir"
  policy      = data.aws_iam_policy_document.bucket.json
  tags = merge(
    { "Name" = format("%s-bucket", local.service_name) },
    var.tags
  )
}

resource "aws_iam_policy" "kms" {
  count = var.enable_kms ? 1 : 0

  name        = format("%s-kms", local.service_name)
  path        = "/"
  description = "Bucket permissions for Mimir"
  policy      = data.aws_iam_policy_document.kms[0].json
  tags = merge(
    { "Name" = format("%s-kms", local.service_name) },
    var.tags
  )
}

module "irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"
  version = "6.2.1"

  for_each = var.enable_irsa ? toset(["1"]) : toset([])

  name        = local.role_name
  description = "Role for Grafana Mimir"

  oidc_providers = {
    main = {
      provider_arn = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
      namespace_service_accounts = [
        ["${var.namespace}:${var.service_account}"]
      ]
    }
  }

  policies = var.enable_kms ? {
    S3BucketPolicy = aws_iam_policy.bucket.arn,
    KMSPolicy      = aws_iam_policy.kms[0].arn,
    } : {
    S3BucketPolicy = aws_iam_policy.bucket.arn,
  }

  tags = merge({
    "Name" = local.role_name
  }, var.tags)
}

module "pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "2.0.0"

  for_each = var.enable_pod_identity ? toset(["1"]) : toset([])

  name = local.role_name

  additional_policy_arns = var.enable_kms ? {
    MimirS3Access : aws_iam_policy.bucket.arn,
    MimirKMSAccess : aws_iam_policy.kms[0].arn,
    AmazonPrometheusRemoteWriteAccess : data.aws_iam_policy.amp_remote_write_access.arn
    } : {
    MimirS3Access : aws_iam_policy.bucket.arn,
    AmazonPrometheusRemoteWriteAccess : data.aws_iam_policy.amp_remote_write_access.arn
  }

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
