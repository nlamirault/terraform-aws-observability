# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

#############################################################################
# Grafana

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "role_policy_arns" {
  description = "Map of ARNs of IAM policies to attach to IAM role"
  type        = map(string)
  default     = {}
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
  description = "Tags for grafana"
  default = {
    "Made-By" = "terraform"
  }
}
