### [목 표]

- Terraform을 활용하여 IaC 방식 AWS EKS 기반 포트폴리오 웹사이트 구축

### [설 명]

- Terraform을 이용하여 IaC 방식 활용
- AWS EKS 기반 컨테이너 오케스트레이션 구현
- React.js 기반 포트폴리오 웹사이트 제작
- CICD 파이프라인을 통한 컨테이너 배포 및 관리

### [진행 계획]

- [X] 1. 테라폼을 활용하여 AWS VPC 생성
- [X] 2. 테라폼을 활용하여 EKS Fargate 생성
- [X] 3. AWS Fargate에서 실행할 CoreDNS 업데이트
- [X] 4. AWS Fargate에 간단한 앱(portfolio) 배포
- [X] 5. AWS Fargate에 매트릭스 서버 배포
- [ ] 6. HPA를 활용하여 CPU 및 메모리 사용량에 따라 오토스케일링
- [ ] 7. 안정성 향상을 위한 파드 중단 예산 생성
- [ ] 8. 테라폼을 사용하여 IAM OIDC 제공자 생성
- [ ] 9. helm 및 테라폼으로 AWS 로드밸런서 배포
- [ ] 10. 간단한 인그레스 제작 및 SSL/TLS 적용
- [ ] 11. 네트워크 로드밸런서 생성
- [ ] 12. EFS와 통합하여 상태 저장 어플리케이션 실행