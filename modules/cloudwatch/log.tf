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

resource "aws_cloudwatch_log_group" "cluster" {
  name              = format("/aws/eks/%s/cluster", data.aws_eks_cluster.id)
  retention_in_days = var.log_retention_in_days

  kms_key_id = var.enable_kms ? aws_kms_key.cloudwatch[0].arn : null

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "container_insights" {
  for_each = local.container_insights_groups

  name              = format("/aws/containerinsights/%s/%s", data.aws_eks_cluster.id, each.key)
  retention_in_days = var.log_retention_in_days

  kms_key_id = var.enable_kms ? aws_kms_key.cloudwatch[0].arn : null

  tags = var.tags
}
