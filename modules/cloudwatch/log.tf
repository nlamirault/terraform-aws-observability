# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

resource "aws_cloudwatch_log_group" "cluster" {
  name              = format("/aws/eks/%s/cluster", data.aws_eks_cluster.this.id)
  retention_in_days = var.log_retention_in_days

  kms_key_id = var.enable_kms ? aws_kms_key.cloudwatch[0].arn : null

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "container_insights" {
  for_each = toset(local.container_insights_groups)

  name              = format("/aws/containerinsights/%s/%s", data.aws_eks_cluster.this.id, each.key)
  retention_in_days = var.log_retention_in_days

  kms_key_id = var.enable_kms ? aws_kms_key.cloudwatch[0].arn : null

  tags = var.tags
}
