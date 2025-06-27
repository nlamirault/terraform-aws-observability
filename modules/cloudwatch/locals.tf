# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

locals {
  role_name = "cloudwatch-agent"
  key_name  = "cloudwatch-agent"

  container_insights_groups = [
    "application",
    "dataplane",
    "host",
    "performance"
  ]
}
