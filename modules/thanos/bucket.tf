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

resource "aws_s3_bucket" "thanos_log" {
  bucket        = format("%s-log", local.service_name)
  acl           = "log-delivery-write"
  force_destroy = true

  tags = merge(
    { "Name" = format("%s-log", local.service_name) },
    local.tags
  )

  versioning {
    enabled = true
  }

  dynamic "server_side_encryption_configuration" {
    for_each = var.enable_kms ? [1] : []
    content {
      server_side_encryption_configuration {
        rule {
          apply_server_side_encryption_by_default {
            kms_master_key_id = aws_kms_key.thanos[0].arn
            sse_algorithm     = "aws:kms"
          }
        }
      }
    }
  }
}

resource "aws_s3_bucket" "thanos" {
  bucket        = local.service_name
  acl           = "private"
  force_destroy = true

  tags = merge(
    { "Name" = local.service_name },
    local.tags
  )

  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.thanos_log.id
    target_prefix = "log/"
  }

  dynamic "server_side_encryption_configuration" {
    for_each = var.enable_kms ? [1] : []
    content {
      server_side_encryption_configuration {
        rule {
          apply_server_side_encryption_by_default {
            kms_master_key_id = aws_kms_key.thanos[0].arn
            sse_algorithm     = "aws:kms"
          }
        }
      }
    }
  }
}
