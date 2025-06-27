# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

#############################################################################
# Amazon Managed Grafana

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "tags" {
  type        = map(string)
  description = "Tags for grafana"
  default = {
    "Made-By" = "Terraform"
  }
}
