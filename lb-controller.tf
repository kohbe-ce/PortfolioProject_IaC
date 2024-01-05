resource "helm_release" "aws-load-balancer-controller" {
  name = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart = "aws-load-balancer-controller"
  namespace = "kube-system"
  version = "1.4.1"

  set {
    name = "clusterName"
    value = aws_eks_cluster.cluster.id
  }

  set {
    name = "image.tag"
    value = "v2.4.2"
  }

  set {
    name = "replicaCount"
    value = 1
  }

  set {
    name = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_load_balancer_controller.arn
  }

  set {
    name = "region"
    value = "ap-northeast-2"
  }

  set {
    name = "vpcId"
    value = aws_vpc.main.id
  }
  depends_on = [ aws_eks_fargate_profile.kube-system ]
}


resource "null_resource" "delete_helm_release" {
  count = var.run_destroy_script ? 1 : 0  # 이 변수를 통해 스크립트 실행 여부 결정

  provisioner "local-exec" {
    command = "etc/delete-helm-release.sh"
  }

  depends_on = [helm_release.aws-load-balancer-controller]
}

variable "run_destroy_script" {
  default = false
}
