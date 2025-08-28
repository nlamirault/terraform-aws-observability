# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    # tflint-ignore: terraform_unused_required_providers
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}
