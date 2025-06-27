# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

data "aws_iam_policy" "cloudwatch_readonly_access" {
  arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

data "aws_iam_policy" "timestream_readonly_access" {
  arn = "arn:aws:iam::aws:policy/AmazonTimestreamReadOnlyAccess"
}

data "aws_iam_policy" "amp_query_access" {
  arn = "arn:aws:iam::aws:policy/AmazonPrometheusQueryAccess"
}
