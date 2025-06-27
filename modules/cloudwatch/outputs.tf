# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

output "irsa_role_arn" {
  value       = [for irsa in module.irsa : irsa.iam_role_arn]
  description = "Amazon Resource Name for Cloudwatch Agent"
}

output "pod_identity_role_arn" {
  value       = [for pod_id in module.pod_identity : pod_id.iam_role_arn]
  description = "Amazon Resource Name for Cloudwatch Agent"
}
