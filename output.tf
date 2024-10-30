## 1-phase 배포 ##
# VPC ID 출력
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.prod_vpc.id
}

# NAT 게이트웨이 공인 IP 출력
output "nat_gateway_public_ip" {
  description = "Public IP address of the NAT Gateway"
  value       = aws_nat_gateway.prod_nat_gw.public_ip
}

## 3-phase 배포시 주석 제거 ##
# # ALB DNS 이름 출력
# output "alb_dns_name" {
#   description = "DNS name of the Application Load Balancer"
#   value       = aws_lb.prod_alb.dns_name
# }

## 4-phase 배포시 주석 제거 ##
# # 웹 서버 인스턴스 ID 출력
# output "web_instance_ids" {
#   description = "IDs of the web server instances"
#   value       = aws_instance.web[*].id
# }

## 5-phase 배포시 주석 제거 ##
# # RDS 엔드포인트 출력
# output "rds_endpoint" {
#   description = "Endpoint of the RDS instance"
#   value       = aws_db_instance.prod_db.endpoint
# }



