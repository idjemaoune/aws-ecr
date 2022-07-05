<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.21.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.21.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.lifecycle_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.repository_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | The encryption type to use for the repository. Valid values are AES256 or KMS. Defaults to AES256 | `string` | `"AES256"` | no |
| <a name="input_global_tags"></a> [global\_tags](#input\_global\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_immutable"></a> [immutable](#input\_immutable) | (Optional) You can configure a repository to be immutable to prevent image tags from being overwritten. Defaults to false | `bool` | `true` | no |
| <a name="input_lifecycle_policy_rules"></a> [lifecycle\_policy\_rules](#input\_lifecycle\_policy\_rules) | (Optional) List of lifecycle policy rules. | `any` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the repository. | `string` | n/a | yes |
| <a name="input_pull_identities"></a> [pull\_identities](#input\_pull\_identities) | (Optional) List of AWS identity identifiers to grant cross account pull access to | `list(string)` | `[]` | no |
| <a name="input_push_identities"></a> [push\_identities](#input\_push\_identities) | (Optional) List of AWS identity identifiers to grant cross account pull and push access to | `list(string)` | `[]` | no |
| <a name="input_repository_policy_statements"></a> [repository\_policy\_statements](#input\_repository\_policy\_statements) | (Optional) A list of repository policy statements. | `any` | `[]` | no |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | (Optional) Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false). Defaults to true | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->