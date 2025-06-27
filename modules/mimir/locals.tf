# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

locals {
  service_name = format("%s-mimir", var.cluster_name)

  role_name = "mimir"

  buckets_names = [
    "admin",
    "alert",
    "ruler",
    "tsdb"
  ]
}
