# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

# trivy:ignore:AVD-AWS-0089
# trivy:ignore:AVD-AWS-0132
# trivy:ignore:AVD-AWS-0088
module "buckets_data" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.11.0"

  for_each = toset(local.buckets_names)

  bucket                  = format("%s-%s", local.service_name, each.value)
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true

  force_destroy = true

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = var.enable_kms ? {
    rule = {
      bucket_key_enabled = true
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.mimir[0].arn
        sse_algorithm     = "aws:kms"
      }
    }
    } : {
    rule = {
      bucket_key_enabled = true
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(
    { "Name" = format("%s-%s", local.service_name, each.value) },
    var.tags
  )
}
