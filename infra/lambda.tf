resource "aws_lambda_function" "lambda_function" {
  function_name = "guardduty-findings-lambda"
  role          = aws_iam_role.lambda_role.arn
  package_type  = "Image"
  architectures = ["arm64"]
  timeout = 20
  image_uri     = "${aws_ecr_repository.lambda_repo.repository_url}:${var.image_tag}"
  environment {
    variables = {
      DETECTOR_ID   = var.detector_id
      SNS_TOPIC_ARN = aws_sns_topic.guardduty_alerts.arn
    }
  }
  depends_on = [ docker_image.guardduty_lambda ]
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "guardduty_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonGuardDutyReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "sns_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecr_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

output "lambda_function_name" {
  value = aws_lambda_function.lambda_function.function_name
}


variable "image_tag" {
  description = "The Docker image tag"
  type        = string
  default     = "latest"
}

variable "detector_id" {
  description = "The GuardDuty detector ID"
  type        = string
}

