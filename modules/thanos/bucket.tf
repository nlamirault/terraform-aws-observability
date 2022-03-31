# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

module "thanos_log" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.15.0"

  bucket                  = format("%s-log", local.service_name)
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true

  acl           = "log-delivery-write"
  force_destroy = true

  tags = merge(
    { "Name" = format("%s-log", local.service_name) },
    local.tags
  )

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = var.enable_kms ? {
    rule = {
      bucket_key_enabled = true
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.thanos[0].arn
        sse_algorithm     = "aws:kms"
      }
    }
  } : {}
}

module "thanos" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.15.0"

  bucket                  = local.service_name
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true

  acl           = "private"
  force_destroy = true

  tags = merge(
    { "Name" = local.service_name },
    local.tags
  )

  logging = {
    target_bucket = module.thanos_log.s3_bucket_id
    target_prefix = "log/"
  }

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = var.enable_kms ? {
    rule = {
      bucket_key_enabled = true
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.thanos[0].arn
        sse_algorithm     = "aws:kms"
      }
    }
  } : {}
}
