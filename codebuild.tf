data "aws_security_group" "default" {
  name = "default"
  vpc_id = aws_vpc.main.id
}

resource "aws_codebuild_project" "cicd-codebuild" {
  name = "cicd-codebuild"
  description = "Portfolio.proj CI/CD Builder"
  service_role = aws_iam_role.codebuild-cicd-build-service-role.arn

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"  # Fargate 이미지 사용
    type         = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true
  }

  source {
    type = "CODECOMMIT"
    location = aws_codecommit_repository.cicd-codecommit.clone_url_http
    buildspec = "buildspec.yml"
  }
    
  vpc_config {
    vpc_id = aws_vpc.main.id
    subnets = [ 
      aws_subnet.private-ap-northeast-2a.id,
      aws_subnet.private-ap-northeast-2b.id
     ]
    security_group_ids = [data.aws_security_group.default.id]
  }

  logs_config {
    cloudwatch_logs {
      group_name = "log-group"
      stream_name = "log-stream"
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE","LOCAL_SOURCE_CACHE"]
  }

}
resource "aws_iam_role" "codebuild-cicd-build-service-role" {
  name = "codebuild-cicd-build-service-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
  }]
  Version = "2012-10-17"
 })
}

resource "aws_iam_role_policy_attachment" "AdministratorAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role = aws_iam_role.codebuild-cicd-build-service-role.id
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.codebuild-cicd-build-service-role.id
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.codebuild-cicd-build-service-role.id
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role = aws_iam_role.codebuild-cicd-build-service-role.id
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role = aws_iam_role.codebuild-cicd-build-service-role.id
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.codebuild-cicd-build-service-role.id
}

resource "aws_iam_role_policy_attachment" "AWSCodeCommitFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
  role = aws_iam_role.codebuild-cicd-build-service-role.id
}

resource "aws_iam_role_policy_attachment" "AWSCodePipeline_FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
  role = aws_iam_role.codebuild-cicd-build-service-role.id
}
