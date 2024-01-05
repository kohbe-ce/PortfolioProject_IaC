#!/bin/bash


# echo "[ INFO ] start delete-helm-release.sh"

# echo "[ INFO ] 헬름 차트 우선 삭제 시작"

# release_name="aws-load-balancer-controller"
# namespace="kube-system"
# confirm=0

# confirm=$(helm delete $release_name --namespace $namespace)
# echo "[ INFO ] 확인 변수값: ${confirm} 헬름 차트 삭제 종료"

  # albarn=$(aws elbv2 describe-load-balancers --region ap-northeast-2 | grep -o "\"LoadBalancerArn\": \"[^\"]*" $JSON | grep -o "[^\"]*$")

  # echo "AWS 로드벨런서 리소스 (ARN) : $albarn 삭제 진행 시작"

  # aws elbv2 delete-load-balancer --load-balancer-arn $albarn --region ap-northeast-2
  # echo "로드벨런서 리소스 삭제"
  # echo "[ INFO ] finish delete-helm-release.sh"


#kubectl delete -f kubernetes/

