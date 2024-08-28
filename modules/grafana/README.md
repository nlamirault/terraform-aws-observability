## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.30.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa"></a> [irsa](#module\_irsa) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 5.44.0 |
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | terraform-aws-modules/eks-pod-identity/aws | 1.4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy.amp_query_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.cloudwatch_readonly_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.timestream_readonly_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | Enable IRSA resources | `bool` | n/a | yes |
| <a name="input_enable_pod_identity"></a> [enable\_pod\_identity](#input\_enable\_pod\_identity) | Enable EKS Pod Identity resources | `bool` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace | `string` | n/a | yes |
| <a name="input_role_policy_arns"></a> [role\_policy\_arns](#input\_role\_policy\_arns) | List of ARNs of IAM policies to attach to IAM role | `list(string)` | `[]` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | The Kubernetes service account | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for grafana | `map(string)` | <pre>{<br>  "Made-By": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_irsa_role_arn"></a> [irsa\_role\_arn](#output\_irsa\_role\_arn) | Amazon Resource Name for Grafana |
| <a name="output_pod_identity_role_arn"></a> [pod\_identity\_role\_arn](#output\_pod\_identity\_role\_arn) | Amazon Resource Name for Grafana |
