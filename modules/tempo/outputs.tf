# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

output "bucket" {
  value       = [for b in module.buckets_data : b.s3_bucket_id]
  description = "S3 bucket for Tempo"
}

output "irsa_role_arn" {
  value       = [for irsa in module.irsa : irsa.iam_role_arn]
  description = "Amazon Resource Name for Tempo"
}

output "pod_identity_role_arn" {
  value       = [for pod_id in module.pod_identity : pod_id.iam_role_arn]
  description = "Amazon Resource Name for Tempo"
}
