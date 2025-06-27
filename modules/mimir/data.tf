# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

data "aws_iam_policy" "amp_remote_write_access" {
  arn = "arn:aws:iam::aws:policy/AmazonPrometheusRemoteWriteAccess"
}
