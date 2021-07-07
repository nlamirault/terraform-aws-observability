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

output "bucket" {
  value       = aws_s3_bucket.thanos.id
  description = "S3 bucket for Thanos"
}

output "role_arn" {
  value       = element(aws_iam_role.thanos.*.arn, 0)
  description = "Amazon Resource Name for Thanos"
}

output "kms_arn" {
  value       = aws_kms_key.thanos.arn
  description = "Amazon Resource Name for Thanos KMS key"
}
