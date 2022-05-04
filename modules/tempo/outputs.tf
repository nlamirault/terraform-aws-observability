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

output "bucket" {
  value       = module.tempo.s3_bucket_id
  description = "S3 bucket for Tempo"
}

output "bucket_log" {
  value       = module.tempo_log.s3_bucket_id
  description = "S3 log bucket for Tempo"
}

output "role_arn" {
  value       = module.tempo_role.iam_role_arn
  description = "Amazon Resource Name for Tempo"
}
