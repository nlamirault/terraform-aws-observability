# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

config {
  module = false
  force = false
  disabled_by_default = false

  ignore_module = {
  }

}

###############################################################################
# Rules

rule "terraform_deprecated_interpolation" { enabled = true }
rule "terraform_deprecated_interpolation" { enabled = true }
rule "terraform_deprecated_index" { enabled = true }
rule "terraform_unused_declarations" { enabled = true }
rule "terraform_comment_syntax" { enabled = true }
rule "terraform_documented_outputs" { enabled = true }
rule "terraform_documented_variables" { enabled = true }
rule "terraform_typed_variables" { enabled = true }
rule "terraform_naming_convention" { enabled = true }
rule "terraform_required_version" { enabled = true }
rule "terraform_required_providers" { enabled = true }
rule "terraform_unused_required_providers" { enabled = true }
rule "terraform_standard_module_structure" { enabled = true }

###############################################################################
# AWS

plugin "aws" {
    enabled = true
    version = "0.41.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
