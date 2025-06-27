# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

locals {
  service_name = format("%s-amg", var.cluster_name)
  description  = format("AWS Managed Grafana service for %s", local.service_name)

  role_name = "aws-managed-grafana"
}
