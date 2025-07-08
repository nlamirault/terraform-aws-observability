# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

data "aws_iam_policy_document" "bucket" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
    ]

    #tfsec:ignore:aws-iam-no-policy-wildcards
    resources = concat(
      [for b in toset(local.buckets_names) : module.buckets_data[b].s3_bucket_arn],
      [for b in toset(local.buckets_names) : format("%s/*", module.buckets_data[b].s3_bucket_arn)]
    )
  }

  dynamic "statement" {
    for_each = var.enable_kms ? toset([1]) : toset([])

    content {
      effect = "Allow"

      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKey*",
      ]

      resources = [aws_kms_key.mimir[0].arn]
    }
  }

}

data "aws_iam_policy_document" "kms" {
  count = var.enable_kms ? 1 : 0

  statement {
    effect = "Allow"

    #tfsec:ignore:aws-iam-no-policy-wildcards
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey*",
    ]

    resources = [
      aws_kms_key.mimir[0].arn
    ]
  }
}

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
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.59.0"

  for_each = var.enable_irsa ? toset(["1"]) : toset([])

  create_role      = true
  role_description = "Role for Tempo"
  role_name        = local.role_name
  provider_url     = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
  role_policy_arns = var.enable_kms ? [
    aws_iam_policy.bucket.arn,
    aws_iam_policy.kms[0].arn,
    data.aws_iam_policy.amp_remote_write_access.arn
    ] : [
    aws_iam_policy.bucket.arn,
    data.aws_iam_policy.amp_remote_write_access.arn
  ]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
  tags = merge(
    { "Name" = local.role_name },
    var.tags
  )
}

module "pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "1.12.1"

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
