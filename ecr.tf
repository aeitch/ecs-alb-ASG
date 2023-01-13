resource "aws_ecr_repository" "aws-ecr" {
  name = var.ecr
  tags = {
    Name        = "${var.app_name}-ecr"
    Environment = var.app_environment
  }
}
