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
| <a name="module_managed_grafana"></a> [managed\_grafana](#module\_managed\_grafana) | terraform-aws-modules/managed-service-grafana/aws | 2.1.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for grafana | `map(string)` | <pre>{<br>  "Made-By": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
