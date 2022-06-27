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

resource "aws_prometheus_workspace" "amp" {
  alias = var.alias
}

module "amp" {
  source  = "terraform-aws-modules/managed-service-prometheus/aws"
  version = "2.1.2"

  workspace_alias = var.alias
}

#tfsec:ignore:AWS099
data "aws_iam_policy_document" "amp" {
  statement {
    actions = [
      "aps:*"
    ]

    resources = [
      module.amp.workspace_arn
    ]
  }
}

resource "aws_iam_policy" "amp" {
  name        = format("%s-aps", local.service_name)
  description = "Prometheus policy for AWS Managed Prometheus"
  policy      = data.aws_iam_policy_document.amp.json
  tags = merge(
    { "Name" = format("%s-aps", local.service_name) },
    local.tags
  )
}

module "prometheus" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.2.0"

  create_role                   = true
  role_description              = "AWS Managed Prometheus role"
  role_name                     = local.role_name
  provider_url                  = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
  role_policy_arns              = [aws_iam_policy.amp.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
  tags = merge(
    { "Name" = local.role_name },
    local.tags
  )
}
