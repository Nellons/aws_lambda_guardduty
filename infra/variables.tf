variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}


variable "email_address" {
  description = "Email address for SNS subscription"
  type        = string
}
