data "aws_security_group" "default" {
  name = "default"
  vpc_id = aws_vpc.main.id
}

resource "aws_codebuild_project" "cicd-codebuild" {
  name = "cicd-codebuild"
  description = "Portfolio.proj CI/CD Builder"
  service_role = ""

  environment {
    
  }

  source {
    
  }
  
  vpc_config {
    
  }

  logs_config {
    
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE","LOCAL_SOURCE_CACHE"]
  }



}