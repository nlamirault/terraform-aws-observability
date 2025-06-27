# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

output "amp_endpoint" {
  value       = module.amp.workspace_prometheus_endpoint
  description = "Prometheus endpoint available for this workspace"
}

output "amp_id" {
  value       = module.amp.workspace_id
  description = "Identifier of the workspace"
}

output "amp_arn" {
  value       = module.amp.workspace_arn
  description = "Amazon Resource Name of the workspace"
}
