# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

locals {
  service_name = format("%s-tempo", var.cluster_name)

  role_name = "tempo"

  buckets_names = [
    "traces"
  ]
}
