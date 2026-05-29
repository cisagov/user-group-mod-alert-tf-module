# ------------------------------------------------------------------------------
# Create an EventBridge event rule for when various IAM or SSO user and group
# events occur.  Connect the event rule to an appropriate SNS topic so that the
# correct folks are notified.
# ------------------------------------------------------------------------------

resource "aws_cloudwatch_event_rule" "this" {
  description = "Capture each time someone creates or deletes an IAM or SSO user, adds or removes a user from a group, or creates or deletes a group."
  event_pattern = jsonencode({
    detail-type = ["AWS API Call via CloudTrail"]
    detail = {
      eventName = [
        "AddUserToGroup",
        "CreateGroup",
        "CreateUser",
        "DeleteGroup",
        "DeleteUser",
        "RemoveUserFromGroup",
      ]
      eventSource = [
        "iam.amazonaws.com",
        "sso-directory.amazonaws.com",
      ],
    }
  })
  name = "capture-user-group-events"
}

resource "aws_cloudwatch_event_target" "this" {
  arn       = var.target_arn
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "SendToSNS"

  input_transformer {
    input_paths = {
      account       = "$.account"
      actor         = "$.detail.userIdentity.arn"
      eventName     = "$.detail.eventName"
      eventSource   = "$.detail.eventSource"
      eventTime     = "$.detail.eventTime"
      rawJson       = "$"
      region        = "$.region"
      requestParams = "$.detail.requestParameters"
      sourceIP      = "$.detail.sourceIPAddress"
      reqUserName   = "$.detail.requestParameters.userName"
      reqGroupName  = "$.detail.requestParameters.groupName"
    }

    input_template = <<-EOT
      "====== IAM/SSO Event Alert ======"
      "Event:      <eventName>"
      "Username:   <reqUserName>"
      "Group:      <reqGroupName>"
      "Source:     <eventSource>"
      "Time:       <eventTime>"
      "Account:    <account>"
      "Region:     <region>"
      "Actor:      <actor>"
      "Source IP:  <sourceIP>"
      "Params:     <requestParams>"
      "Raw JSON:"
      "<rawJson>"
    EOT
  }
}
