# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

module "irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "6.2.1"

  for_each = var.enable_irsa ? toset(["1"]) : toset([])

  create_role      = true
  role_description = "Role for Grafana"
  role_name        = local.role_name
  provider_url     = data.aws_eks_cluster.this.identity[0].oidc[0].issuer

  role_policy_arns = concat([
    data.aws_iam_policy.cloudwatch_readonly_access.arn,
    data.aws_iam_policy.timestream_readonly_access.arn,
    data.aws_iam_policy.amp_query_access.arn
  ], var.role_policy_arns)

  oidc_fully_qualified_subjects  = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
  oidc_fully_qualified_audiences = ["sts.amazonaws.com"]

  tags = merge(
    { "Name" = local.role_name },
    var.tags
  )
}

module "pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "1.12.1"

  for_each = var.enable_pod_identity ? toset(["1"]) : toset([])

  name = local.role_name

  # attach_custom_policy = true
  additional_policy_arns = {
    CloudWatchReadOnlyAccess       = data.aws_iam_policy.cloudwatch_readonly_access.arn,
    AmazonTimestreamReadOnlyAccess = data.aws_iam_policy.timestream_readonly_access.arn,
    AmazonPrometheusQueryAccess    = data.aws_iam_policy.amp_query_access.arn
  }

  associations = {
    main = {
      cluster_name    = data.aws_eks_cluster.this.id
      namespace       = var.namespace
      service_account = var.service_account
    }
  }

  tags = merge(
    { "Name" = local.role_name },
    var.tags
  )
}
