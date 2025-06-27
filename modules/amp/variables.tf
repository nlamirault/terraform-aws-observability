# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

# AWS Managed Prometheus

variable "name" {
  description = "Workspace name"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources"
  default = {
    "Made-By" = "Terraform"
  }
}
