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

data "aws_iam_policy_document" "thanos_permissions" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
    ]

    resources = [
      module.thanos_log.s3_bucket_arn,
      "${module.thanos_log.s3_bucket_arn}/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey*",
    ]

    resources = var.enable_kms ? [aws_kms_key.thanos[0].arn] : []
  }

}

resource "aws_iam_policy" "thanos" {
  name        = local.service_name
  path        = "/"
  description = "Permissions for Thanos"
  policy      = data.aws_iam_policy_document.thanos_permissions.json
  tags = merge(
    { "Name" = local.service_name },
    local.tags
  )
}

module "thanos_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.7.0"

  for_each = toset(var.service_accounts)

  create_role                   = true
  role_description              = "thanos Role"
  role_name                     = local.role_name
  provider_url                  = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
  role_policy_arns              = [aws_iam_policy.thanos.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${each.value}"]
  tags = merge(
    { "Name" = local.role_name },
    local.tags
  )
}
