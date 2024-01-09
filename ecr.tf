resource "aws_ecr_repository" "cicd-ecr" {
 name = "cicd-ecr"
 image_tag_mutability = "MUTABLE"
 
 image_scanning_configuration {
  scan_on_push = true
 }

 tags = {
   Name = "cicd-ecr"
 }
}
