# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

data "aws_iam_policy" "amp_remote_write_access" {
  arn = "arn:aws:iam::aws:policy/AmazonPrometheusRemoteWriteAccess"
}

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
