# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

module "amp" {
  source  = "terraform-aws-modules/managed-service-prometheus/aws"
  version = "3.1.1"

  workspace_alias = var.name

  tags = var.tags
}
