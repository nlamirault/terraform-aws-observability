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

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_secretsmanager_secret_version.oidc_url.secret_binary, "https://", "")}:sub"
      values   = [format("system:serviceaccount:%s:%s", var.namespace, var.service_account)]
    }

    principals {
      identifiers = [data.aws_secretsmanager_secret_version.oidc_arn.secret_binary]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "loki" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = local.service_name
  tags               = var.tags
}

data "aws_iam_policy_document" "loki_permissions" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.loki.arn,
      "${aws_s3_bucket.loki.arn}/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey*",
    ]

    resources = [
      aws_kms_key.loki.arn
    ]
  }

}

resource "aws_iam_policy" "loki_permissions" {
  name        = local.service_name
  path        = "/"
  description = "Permissions for Loki"
  policy      = data.aws_iam_policy_document.loki_permissions.json
}

resource "aws_iam_role_policy_attachment" "loki" {
  role       = aws_iam_role.loki.name
  policy_arn = aws_iam_policy.loki_permissions.arn
}
