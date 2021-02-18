# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

data "aws_secretsmanager_secret" "oidc_url" {
  name = format("%s_k8s_oidc_url", replace(var.cluster_name, "-", "_"))
}

data "aws_secretsmanager_secret_version" "oidc_url" {
  secret_id = data.aws_secretsmanager_secret.oidc_url.id
}

data "aws_secretsmanager_secret" "oidc_arn" {
  name = format("%s_k8s_oidc_arn", replace(var.cluster_name, "-", "_"))
}

data "aws_secretsmanager_secret_version" "oidc_arn" {
  secret_id = data.aws_secretsmanager_secret.oidc_arn.id
}

data "aws_s3_bucket" "thanos" {
  bucket = var.bucket_name
}

data "aws_kms_key" "thanos" {
  key_id = "alias/thanos"
}
