resource "aws_codepipeline" "cicd-pipeline" {
  name     = "cicd-pipeline"
  role_arn = aws_iam_role.codepipeline-cicd-pipeline-role.arn

  artifact_store {
    location =aws_s3_bucket.cicdpipeline-s3-bucket-0119.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name     = "Source"
      category = "Source"
      owner    = "AWS"
      provider = "CodeCommit"
      version  = "1"

      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName      = "portfolio-cicd-repository"
        BranchName          = "main"
        PollForSourceChanges = false
      }
    }
  }

  stage {
    name = "Build"
    action {
      name     = "Build"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version  = "1"

      configuration = {
        ProjectName = aws_codebuild_project.cicd-codebuild.name
      }
    }
  }

  # stage {
  #   name = "Deploy"
  #   action {
  #     name     = "Deploy"
  #     category = "Deploy"
  #     owner    = "AWS"
  #     provider = "EKS"
  #     version  = "1"

  #     input_artifacts = ["build_output"]

  #     configuration = {
  #       ClusterName = aws_eks_cluster.cluster.name
  #       ActionMode  = "REPLACE_ON_FAILURE"
  #       RoleArn     = aws_iam_role.codepipeline-cicd-pipeline-role.arn
  #       Region      = "ap-northeast-2"
  #       RunOrder    = "1"
  #     }
  #   }
  # }
}

resource "aws_iam_role" "codepipeline-cicd-pipeline-role" {
  name = "codepipeline-cicd-pipeline-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "codepipeline.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}
resource "aws_iam_role_policy_attachment" "AWSCodePipeline_FullAccess1" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
  role = aws_iam_role.codepipeline-cicd-pipeline-role.id
}
resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role = aws_iam_role.codepipeline-cicd-pipeline-role.id
}
resource "aws_iam_role_policy_attachment" "AWSCodeBuildAdminAccess1" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
  role = aws_iam_role.codepipeline-cicd-pipeline-role.id
}
resource "aws_iam_role_policy_attachment" "AWSCodeBuildReadOnlyAccess1" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildReadOnlyAccess"
  role = aws_iam_role.codepipeline-cicd-pipeline-role.id
}
resource "aws_iam_role_policy_attachment" "AWSCodeCommitFullAccess1" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
  role = aws_iam_role.codepipeline-cicd-pipeline-role.id
}
resource "aws_iam_role_policy_attachment" "AWSCodeCommitReadOnly1" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitReadOnly"
  role = aws_iam_role.codepipeline-cicd-pipeline-role.id
}
resource "aws_iam_role_policy_attachment" "AWSProtonCodeBuildProvisioningBasicAccess1" {
  policy_arn = "arn:aws:iam::aws:policy/AWSProtonCodeBuildProvisioningBasicAccess"
  role = aws_iam_role.codepipeline-cicd-pipeline-role.id
}

