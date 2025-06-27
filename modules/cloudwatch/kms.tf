# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

resource "aws_kms_key" "cloudwatch" {
  count                   = var.enable_kms ? 1 : 0
  description             = local.key_name
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true
  tags = merge(
    { "Name" = local.key_name },
    var.tags
  )
}

resource "aws_kms_alias" "cloudwatch" {
  count         = var.enable_kms ? 1 : 0
  name          = "alias/cloudwatch"
  target_key_id = aws_kms_key.cloudwatch[0].key_id
}
