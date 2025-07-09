# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

#tfsec:ignore:aws-iam-no-policy-wildcards
module "managed_grafana" {
  source  = "terraform-aws-modules/managed-service-grafana/aws"
  version = "2.3.0"

  # Workspace
  name                      = local.service_name
  description               = local.description
  account_access_type       = "CURRENT_ACCOUNT"
  authentication_providers  = ["AWS_SSO"]
  permission_type           = "SERVICE_MANAGED"
  data_sources              = ["CLOUDWATCH", "PROMETHEUS", "XRAY"]
  notification_destinations = ["SNS"]

  # Workspace IAM role
  create_iam_role                = true
  iam_role_name                  = local.role_name
  use_iam_role_name_prefix       = true
  iam_role_description           = local.description
  iam_role_path                  = "/grafana/"
  iam_role_force_detach_policies = true
  iam_role_max_session_duration  = 7200
  iam_role_tags                  = { role = true }

  tags = merge(
    { "Name" = format("%s-amg", local.service_name) },
    var.tags
  )
}
