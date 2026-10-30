# Create ECR repository
resource "aws_ecr_repository" "ecr" {
  name                 = "${var.name}-ecr"
  image_tag_mutability = "IMMUTABLE_WITH_EXCLUSION"

  image_scanning_configuration {
    scan_on_push = false
  }
  image_tag_mutability_exclusion_filter {
    filter      = "latest*"
    filter_type = "WILDCARD"
  }
}