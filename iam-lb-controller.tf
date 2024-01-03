# k8s service account - aws
data "aws_iam_policy_document" "aws_load_balancer_controller_assume_role_policy"{
  statement {
    actions = [ "sts:AssumeRoleWithWebIdentity" ]
    effect = "Allow"

    condition {
      test = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://","")}:sub"

      # kube-system 네임스페이스에 aws-load-balancer-controller라는 serviceaccount 지정
      values = [ "system:serviceaccount:kube-system:aws-load-balancer-controller" ]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type = "Federated"
    }
  }
}

resource "aws_iam_role" "aws_load_balancer_controller" {
  # 역할에 lb 생성 및 관리 aws권한 부여
  assume_role_policy = data.aws_iam_policy_document.aws_load_balancer_controller_assume_role_policy.json
  name               = "aws-load-balancer-controller"
}

resource "aws_iam_policy" "aws_load_balancer_controller" {
  policy = file("./AWSLoadBalancerController.json")
  name   = "AWSLoadBalancerController"
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller_attach" {
  role       = aws_iam_role.aws_load_balancer_controller.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
}

output "aws_load_balancer_controller_role_arn" {
  value = aws_iam_role.aws_load_balancer_controller.arn
}