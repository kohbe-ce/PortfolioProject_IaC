resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  # EFS를 위한 설정 : CSI 드라이버가 EFS 엔드포인트 확인 설정
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    "Name" = "main"
  }
}

