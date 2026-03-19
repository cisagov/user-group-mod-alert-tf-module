# user-group-mod-alert-tf-module #

[![GitHub Build Status](https://github.com/cisagov/user-group-mod-alert-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/user-group-mod-alert-tf-module/actions)
[![License](https://img.shields.io/github/license/cisagov/user-group-mod-alert-tf-module)](https://spdx.org/licenses/)
[![CodeQL](https://github.com/cisagov/user-group-mod-alert-tf-module/workflows/CodeQL/badge.svg)](https://github.com/cisagov/user-group-mod-alert-tf-module/actions/workflows/codeql-analysis.yml)

A Terraform module for creating an EventBridge event that triggers whenever a
new IAM or SSO user is created or deleted, a user is added or removed from a
group, or a group is created or deleted.

## Usage ##

```hcl
module "example" {
  source = "github.com/cisagov/user-group-mod-alert-tf-module?ref=v1.0.0"

  target_arn = "arn:aws:sns:us-east-1:012345678901:my-sns-topic"
}
```

## Examples ##

- [Basic usage](https://github.com/cisagov/user-group-mod-alert-tf-module/tree/develop/examples/basic_usage)

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
| ---- | ------- |
| terraform | >= 1.1 |
| aws | >= 4.9 |

## Providers ##

| Name | Version |
| ---- | ------- |
| aws | >= 4.9 |

## Modules ##

No modules.

## Resources ##

| Name | Type |
| ---- | ---- |
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |

## Inputs ##

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| target\_arn | The ARN of a target (usually an SNS topic) that should be notified when a new IAM or SSO user is created or deleted, a user is added or removed from a group, or a group is created or deleted (e.g. arn:aws:sns:us-east-1:012345678901:my-sns-topic). | `string` | n/a | yes |

## Outputs ##

| Name | Description |
| ---- | ----------- |
| rule | The EventBridge event rule that will be triggered when a new IAM or SSO user is created or deleted, a user is added or removed from a group, or a group is created or deleted. |
| target | The EventBridge event target for the rule. |
<!-- END_TF_DOCS -->

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, these are the main directory and
every directory under `examples/`.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
