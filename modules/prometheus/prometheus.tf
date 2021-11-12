# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

data "aws_iam_policy_document" "prometheus_permissions" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
    ]

    resources = [
      data.aws_s3_bucket.thanos.arn,
      "${data.aws_s3_bucket.thanos.arn}/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey*",
    ]

    resources = var.enable_kms ? [data.aws_kms_key.thanos[0].arn] : []
  }
}

resource "aws_iam_policy" "prometheus" {
  name        = local.service_name
  path        = "/"
  description = "Permissions for Prometheus"
  policy      = data.aws_iam_policy_document.prometheus_permissions.json
  tags = merge(
    { "Name" = local.service_name },
    local.tags
  )
}

module "prometheus_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.7.0"

  create_role                   = true
  role_description              = "prometheus Role"
  role_name                     = var.prometheus_role_name
  provider_url                  = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
  role_policy_arns              = [aws_iam_policy.prometheus.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
  tags = merge(
    { "Name" = var.prometheus_role_name },
    local.tags
  )
}
