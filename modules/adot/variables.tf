# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "namespace" {
  type        = string
  description = "The Kubernetes namespace"
}

variable "service_account" {
  type        = string
  description = "The Kubernetes service account"
}

variable "enable_irsa" {
  type        = bool
  description = "Enable IRSA resources"
}

variable "enable_pod_identity" {
  type        = bool
  description = "Enable EKS Pod Identity resources"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources"
  default = {
    "Made-By" = "Terraform"
  }
}
