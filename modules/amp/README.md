# Observability / AWS Managed Service for Prometheus

Terraform module which configure an AWS managed service for Prometheus instance.

## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_prometheus"></a> [prometheus](#module\_prometheus) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.23.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.amp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_prometheus_workspace.amp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/prometheus_workspace) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.amp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias"></a> [alias](#input\_alias) | Workspace name | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | The Kubernetes service account | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_amp_endpoint"></a> [amp\_endpoint](#output\_amp\_endpoint) | Prometheus endpoint available for this workspace |
| <a name="output_amp_id"></a> [amp\_id](#output\_amp\_id) | Identifier of the workspace |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
