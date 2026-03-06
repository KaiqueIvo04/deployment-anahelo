resource "aws_ecr_repository" "inventorycontrol_repo_frontend" {
  name                 = "app_prod"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "inventorycontrol_repo_backend" {
  name                 = "server_prod"
  image_tag_mutability = "MUTABLE"
}