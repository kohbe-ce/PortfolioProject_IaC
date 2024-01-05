#!/bin/bash

# albarn=$(aws elbv2 describe-load-balancers --region ap-northeast-2 | grep -w LoadBalancerArn | awk -F\" '{print $4}')
albarn=$(aws elbv2 describe-load-balancers --region ap-northeast-2 | grep -o "\"LoadBalancerArn\": \"[^\"]*" $JSON | grep -o "[^\"]*$")

echo "AWS 로드벨런서 리소스 (ARN) : $albarn 삭제 진행 시작"

#aws elbv2 delete-load-balancer --load-balancer-arn $albarn --region ap-northeast-2



#aws elbv2 delete-target-group --target-group-arn arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/my-targets/73e2d6bc24d8a067 --region ap-northeast-2
echo albarn=$(aws elbv2 describe-load-balancers --region ap-northeast-2 | grep -o "\"LoadBalancerArn\": \"[^\"]*" $JSON | grep -o "[^\"]*$")

aws elbv2 describe-target-groups \
    --load-balancer-arn $albarn \
    --query TargetGroups[*].TargetGroupName