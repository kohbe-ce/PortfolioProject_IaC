provider "aws" {
  region = "ap-northeast-2"
}

variable "cluster_name" {
  default = "portfolio_kohbe_cluster"
}

variable "cluster_version" {
  default = "1.24"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
