# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

resource "aws_kms_key" "loki" {
  count                   = var.enable_kms ? 1 : 0
  description             = "KMS for Loki"
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true

  tags = merge(
    { "Name" = local.service_name },
    var.tags
  )
}

resource "aws_kms_alias" "loki" {
  count         = var.enable_kms ? 1 : 0
  name          = "alias/loki"
  target_key_id = aws_kms_key.loki[0].key_id
}
