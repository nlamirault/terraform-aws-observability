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
