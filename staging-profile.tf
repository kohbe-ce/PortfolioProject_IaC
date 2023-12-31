resource "aws_eks_fargate_profile" "staging" {
  cluster_name = aws_eks_cluster.cluster.name
  fargate_profile_name = "staging"
  pod_execution_role_arn = aws_iam_role.eks-fargate-profile.arn

  subnet_ids = [ 
    aws_subnet.private-ap-northeast-2a.id,
    aws_subnet.private-ap-northeast-2b.id
   ]

   selector {
     namespace = "staging"
   }
}
