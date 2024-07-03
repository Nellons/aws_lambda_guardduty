resource "aws_sns_topic" "guardduty_alerts" {
  name = "guardduty-alerts"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.guardduty_alerts.arn
  protocol  = "email"
  endpoint  = var.email_address
  endpoint_auto_confirms = true
}


