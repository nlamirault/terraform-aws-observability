# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

module "irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.48.0"

  for_each = var.enable_irsa ? toset(["1"]) : toset([])

  create_role      = true
  role_description = "Prometheus Role"
  role_name        = local.role_name
  provider_url     = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
  role_policy_arns = [
    data.aws_iam_policy.amp_remote_write_access.arn,
    data.aws_iam_policy.ec2_ro_access.arn
  ]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
  tags = merge(
    { "Name" = local.role_name },
    var.tags
  )
}

module "pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "1.4.0"

  for_each = var.enable_pod_identity ? toset(["1"]) : toset([])

  name = local.role_name

  # attach_custom_policy = true
  additional_policy_arns = {
    AmazonPrometheusRemoteWriteAccess : data.aws_iam_policy.amp_remote_write_access.arn,
    AmazonEC2ReadOnlyAccess : data.aws_iam_policy.ec2_ro_access.arn
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
