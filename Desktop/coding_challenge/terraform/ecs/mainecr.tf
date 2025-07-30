resource "aws_ecr_repository" "my_repository" {
  name                 = "my-application-repo" # Name your repository
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}
