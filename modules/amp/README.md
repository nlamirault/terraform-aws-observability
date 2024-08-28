## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_amp"></a> [amp](#module\_amp) | terraform-aws-modules/managed-service-prometheus/aws | 3.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Workspace name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for resources | `map(string)` | <pre>{<br>  "Made-By": "Terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_amp_arn"></a> [amp\_arn](#output\_amp\_arn) | Amazon Resource Name of the workspace |
| <a name="output_amp_endpoint"></a> [amp\_endpoint](#output\_amp\_endpoint) | Prometheus endpoint available for this workspace |
| <a name="output_amp_id"></a> [amp\_id](#output\_amp\_id) | Identifier of the workspace |
