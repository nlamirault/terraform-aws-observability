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

data "aws_s3_bucket" "thanos" {
  bucket = var.bucket_name
}

data "aws_kms_key" "thanos" {
  count  = var.enable_kms ? 1 : 0
  key_id = "alias/thanos"
}

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

# https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-and-IAM.html
data "aws_iam_policy" "amp_remote_write_access" {
  arn = "arn:aws:iam::aws:policy/AmazonPrometheusRemoteWriteAccess"
}

data "aws_iam_policy" "ec2_ro_access" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
