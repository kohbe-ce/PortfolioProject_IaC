resource "aws_codecommit_repository" "cicd-codecommit" {
  repository_name = "portfolio-cicd-repository"
  description = "Portfolio.proj CI/CD Repository"
}