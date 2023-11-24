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

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

data "aws_iam_policy" "cloudwatch_readonly_access" {
  arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

data "aws_iam_policy" "timestream_readonly_access" {
  arn = "arn:aws:iam::aws:policy/AmazonTimestreamReadOnlyAccess"
}

data "aws_iam_policy" "amp_query_access" {
  arn = "arn:aws:iam::aws:policy/AmazonPrometheusQueryAccess"
}
