data "aws_ecr_authorization_token" "ecr" {}

resource "docker_image" "guardduty_lambda" {
  name = "${aws_ecr_repository.lambda_repo.repository_url}:${var.image_tag}"
  build {
    context    = "${path.module}/../"
    dockerfile = "${path.module}/../Dockerfile"
    auth_config {
      host_name = aws_ecr_repository.lambda_repo.registry_id
      auth = data.aws_ecr_authorization_token.ecr.authorization_token
    }
    build_arg = {
      DETECTOR_ID   : var.detector_id
      SNS_TOPIC_ARN : aws_sns_topic.guardduty_alerts.arn
    }
  }

  provisioner "local-exec" {
    command = <<-EOT
      aws ecr get-login-password --region ${var.aws_region} --profile tf-user| docker login --username AWS --password-stdin ${data.aws_ecr_authorization_token.ecr.proxy_endpoint}
      docker push ${aws_ecr_repository.lambda_repo.repository_url}:${var.image_tag}
    EOT
  }
}
