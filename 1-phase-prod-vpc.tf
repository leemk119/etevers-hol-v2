# Terraform 설정 및 프로바이더 정의
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS 프로바이더 설정
provider "aws" {
  region = var.region
}

# VPC 생성
resource "aws_vpc" "prod_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "prod-vpc"
  }
}

# 퍼블릭 서브넷 생성
resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = var.subnet_cidrs.public[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "prod-public-subnet-${count.index + 1}"
  }
}

# 프라이빗 웹 서브넷 생성
resource "aws_subnet" "private_web" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = var.subnet_cidrs.private_web[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "prod-private-web-subnet-${count.index + 1}"
  }
}

# 프라이빗 WAS 서브넷 생성
resource "aws_subnet" "private_was" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = var.subnet_cidrs.private_was[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "prod-private-was-subnet-${count.index + 1}"
  }
}

# 프라이빗 DB 서브넷 생성
resource "aws_subnet" "private_db" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = var.subnet_cidrs.private_db[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "prod-private-db-subnet-${count.index + 1}"
  }
}

# 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "prod-igw"
  }
}

# NAT 게이트웨이용 Elastic IP 생성
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "prod-nat-eip"
  }
}

# NAT 게이트웨이 생성
resource "aws_nat_gateway" "prod_nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "prod-nat-gw"
  }
}