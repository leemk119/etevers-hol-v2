# # ALB 보안 그룹
# resource "aws_security_group" "alb_sg" {
#   name        = "prod-alb-sg"
#   description = "Security Group for ALB"
#   vpc_id      = aws_vpc.prod_vpc.id

#   # 인바운드 규칙: HTTP 트래픽 허용
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # 아웃바운드 규칙: 모든 트래픽 허용
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "prod-alb-sg"
#   }
# }

# # 웹 서버 보안 그룹
# resource "aws_security_group" "web_sg" {
#   name        = "prod-web-sg"
#   description = "Security Group for Web servers"
#   vpc_id      = aws_vpc.prod_vpc.id

#   # 인바운드 규칙: ALB로부터의 HTTP 트래픽 허용
#   ingress {
#     from_port       = 80
#     to_port         = 80
#     protocol        = "tcp"
#     security_groups = [aws_security_group.alb_sg.id]
#   }

#   # 아웃바운드 규칙: 모든 트래픽 허용
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "prod-web-sg"
#   }
# }

# # DB 보안 그룹
# resource "aws_security_group" "db_sg" {
#   name        = "prod-db-sg"
#   description = "Security Group for Database"
#   vpc_id      = aws_vpc.prod_vpc.id

#   # 인바운드 규칙: 웹 서버로부터의 MySQL 트래픽 허용
#   ingress {
#     from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
#     security_groups = [aws_security_group.web_sg.id]
#   }

#   # 아웃바운드 규칙: 모든 트래픽 허용
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "prod-db-sg"
#   }
# }