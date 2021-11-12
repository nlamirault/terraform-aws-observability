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

resource "aws_iam_policy" "grafana" {
  name        = local.service_name
  description = "Permissions for Grafana"
  path        = "/"
  policy      = file("grafana_policy.json")
  tags = merge(
    { "Name" = local.service_name },
    local.tags
  )
}

module "grafana_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.7.0"

  create_role                   = true
  role_description              = "Grafana Role"
  role_name                     = var.grafana_role_name
  provider_url                  = replace(var.provider_url, "https://", "")
  role_policy_arns              = [aws_iam_policy.grafana.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
  tags = merge(
    { "Name" = var.grafana_role_name },
    local.tags
  )
}
