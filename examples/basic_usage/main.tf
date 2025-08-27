provider "aws" {
  # Our primary provider uses our Terraform role
  assume_role {
    role_arn     = var.tf_role_arn
    session_name = "terraform-example"
  }
  default_tags {
    tags = var.tags
  }
  region = var.aws_region
}

#-------------------------------------------------------------------------------
# Create an SNS topic to notify.
#-------------------------------------------------------------------------------
resource "aws_sns_topic" "this" {
  display_name = "SNS topic to be notified when a new IAM or SSO user is created or deleted, a user is added or removed from a group, or a group is created or deleted."
  name         = "user-group-mod-topic"
}

#-------------------------------------------------------------------------------
# Configure the module.
#-------------------------------------------------------------------------------
module "example" {
  source = "../../"
  providers = {
    aws = aws
  }

  target_arn = aws_sns_topic.this.arn
}
