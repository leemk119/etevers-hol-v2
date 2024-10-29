# AWS 리전 설정
variable "region" {
  description = "AWS region"
  default     = "ap-northeast-2"
}

# VPC CIDR 블록 설정
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

# 가용영역 설정
variable "availability_zones" {
  description = "List of availability zones"
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

# 서브넷 CIDR 블록 설정
variable "subnet_cidrs" {
  description = "CIDR blocks for subnets"
  default = {
    public     = ["10.0.1.0/24", "10.0.2.0/24"]
    private_web = ["10.0.6.0/24", "10.0.7.0/24"]
    private_was = ["10.0.11.0/24", "10.0.12.0/24"]
    private_db  = ["10.0.16.0/24", "10.0.17.0/24"]
  }
}

# EC2 인스턴스 타입 설정
variable "ec2_instance_type" {
  description = "EC2 instance type"
  default     = "t3.small"
}

# EC2 AMI ID 설정
variable "ec2_ami" {
  description = "AMI ID for EC2 instances"
  default     = "ami-02c329a4b4aba6a48"  # Amazon Linux 2023 AMI
}

# EC2 키 페어 이름 설정
variable "ec2_key_name" {
  description = "Key pair name for EC2 instances"
  type        = string
}

# RDS 데이터베이스 비밀번호 설정 (민감한 정보이므로 default 값은 설정하지 않음)
variable "db_password" {
  description = "Password for the RDS database"
  type        = string
}