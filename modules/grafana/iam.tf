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

module "irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.32.0"

  create_role      = true
  role_description = "Role for Grafana"
  role_name        = local.role_name
  provider_url     = data.aws_eks_cluster.this.identity[0].oidc[0].issuer

  role_policy_arns = concat([
    data.aws_iam_policy.cloudwatch_readonly_access.arn,
    data.aws_iam_policy.timestream_readonly_access.arn,
    data.aws_iam_policy.amp_query_access.arn
  ], var.role_policy_arns)

  oidc_fully_qualified_subjects  = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
  oidc_fully_qualified_audiences = ["sts.amazonaws.com"]

  tags = merge(
    { "Name" = local.role_name },
    var.tags
  )
}
