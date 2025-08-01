# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

#############################################################################
# Cloudwatch

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "log_retention_in_days" {
  description = "Number of days to retain log events"
  type        = number
  default     = 90
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
  description = "Tags for Cloudwatch"
  default = {
    Made-By = "Terraform"
  }
}

#############################################################################
# KMS

variable "enable_kms" {
  type        = bool
  description = "Enable custom KMS key"
}

variable "deletion_window_in_days" {
  type        = number
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days"
  default     = 30
}
