# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
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
    resources = [
      module.buckets_data[*].s3_bucket_arn,
      "${module.buckets_data[*].s3_bucket_arn}/*"
    ]
  }

  dynamic "statement" {
    for_each = var.enable_kms ? [1] : []

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
  version = "5.37.1"

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
