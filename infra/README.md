<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.56.1 |
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | 3.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.56.1 |
| <a name="provider_docker"></a> [docker](#provider\_docker) | 3.0.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.lambda_repo](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/ecr_repository) | resource |
| [aws_iam_role.lambda_role](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.guardduty_policy](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.sns_policy](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/lambda_function) | resource |
| [aws_sns_topic.guardduty_alerts](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.email_subscription](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/sns_topic_subscription) | resource |
| [docker_image.guardduty_lambda](https://registry.terraform.io/providers/kreuzwerker/docker/3.0.2/docs/resources/image) | resource |
| [aws_ecr_authorization_token.ecr](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/data-sources/ecr_authorization_token) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to deploy to | `string` | `"us-east-1"` | no |
| <a name="input_detector_id"></a> [detector\_id](#input\_detector\_id) | The GuardDuty detector ID | `string` | n/a | yes |
| <a name="input_email_address"></a> [email\_address](#input\_email\_address) | Email address for SNS subscription | `string` | n/a | yes |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | The Docker image tag | `string` | `"latest"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | n/a |
<!-- END_TF_DOCS -->