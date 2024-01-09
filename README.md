### [목 표]

- Terraform을 활용하여 IaC 방식 AWS EKS 기반 포트폴리오 웹사이트 구축( URL : conas.xyz )

### [설 명]

- Terraform을 이용하여 IaC 방식 활용
- AWS EKS 기반 컨테이너 오케스트레이션 구현
    - Fargate Pods 운영
    - HPA 오토스케일링 구현
- React.js 기반 포트폴리오 웹사이트 제작
- CICD 파이프라인을 통한 컨테이너 배포 및 관리
    - ECR
    - CodeCommit
    - CodePipeline
    - CodeBulid
    - CodeDeploy
- 모니터링 페이지 제작

### [진행 계획]

- [X] 1. 테라폼을 활용하여 AWS VPC 생성
- [X] 2. 테라폼을 활용하여 EKS Fargate 생성
- [X] 3. AWS Fargate에서 실행할 CoreDNS 업데이트
- [X] 4. AWS Fargate에 간단한 앱(portfolio) 배포
- [X] 5. AWS Fargate에 매트릭스 서버 배포
- [X] 6. HPA를 활용하여 CPU 및 메모리 사용량에 따라 오토스케일링
- [X] 7. 안정성 향상을 위한 파드 중단 예산 생성
- [X] 8. 테라폼을 사용하여 IAM OIDC 제공자 생성
- [X] 9. helm 및 테라폼으로 AWS 로드밸런서 배포
- [X] 10. 간단한 인그레스 제작
- [X] 11. 포트폴리오 페이지 제작
- [X] 12. 컨테이너 제작 및 ECR 생성
- [X] 13. CICD 파이프라인 제작
- [ ] 14. 모니터링 페이지 제작
- [ ] 15. Terraform 코드 모듈화


### [재구성 시 전처리 사항]

1. AWS 서비스 기동
    #terraform apply
2. AWS Config 적용
    #aws eks update-kubeconfig --name portfolio_kohbe_cluster --region ap-northeast-2
3. EKS 기본 파드 기동
    #kubectl apply -f kubernetes/
4. Ingress-Controller 연결 로드 벨런서 주소 확인
    #kubectl get ingress -A
5. 가비아 dns 내 elb 도메인 변경