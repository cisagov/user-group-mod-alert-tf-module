# Notify an SNS Topic When Certain IAM or SSO User or Group Events Occur #

Specifically, the SNS topic is notified when a new IAM or SSO user is created
or deleted, a user is added or removed from a group, or a group is created or
deleted.

## Usage ##

To run this example you need to execute the `terraform init` command
followed by the `terraform apply` command.

Note that this example may create resources which cost money. Run
`terraform destroy` when you no longer need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.1 |
| aws | ~> 6.7 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 6.7 |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| example | ../../ | n/a |

## Resources ##

| Name | Type |
|------|------|
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region to deploy into (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | ```{ "Testing": true }``` | no |
| tf\_role\_arn | The ARN of the role that can terraform non-specialized resources. | `string` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| rule | The EventBridge event rule that will be triggered when a new IAM or SSO user is created. |
| target | The EventBridge event target for the rule. |
| topic | The SNS topic that will be notified when a new IAM or SSO user is created. |
<!-- END_TF_DOCS -->
