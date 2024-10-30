# # RDS 인스턴스 생성
# resource "aws_db_instance" "prod_db" {
#   identifier        = "prod-main-db"
#   engine            = "mysql"
#   engine_version    = "8.0"
#   instance_class    = "db.t3.micro"
#   allocated_storage = 20
#   storage_type      = "gp3"

#   db_name  = "mydb"
#   username = "admin"
#   password = var.db_password

#   vpc_security_group_ids = [aws_security_group.db_sg.id]
#   db_subnet_group_name   = aws_db_subnet_group.prod_db_subnet_group.name

#   multi_az               = true
#   skip_final_snapshot    = true
#   backup_retention_period = 7

#   tags = {
#     Name = "prod-main-db"
#   }
# }

# # DB 서브넷 그룹 생성
# resource "aws_db_subnet_group" "prod_db_subnet_group" {
#   name       = "prod-db-subnet-group"
#   subnet_ids = aws_subnet.private_db[*].id

#   tags = {
#     Name = "prod-db-subnet-group"
#   }
# }

# # DB 파라미터 그룹 생성
# resource "aws_db_parameter_group" "prod_db_pg" {
#   family = "mysql8.0"  # MySQL 8.0 파라미터 그룹 패밀리
#   name   = "prod-db-pg"  # 파라미터 그룹 이름

#   # 문자셋 및 콜레이션 설정
#   parameter {
#     name  = "character_set_server"
#     value = "utf8mb4"
#   }
#   parameter {
#     name  = "collation_server"
#     value = "utf8mb4_unicode_ci"  # 유니코드 대소문자 구분 없는 정렬
#   }

#   tags = {
#     Name = "prod-db-parameter-group"  # 리소스 태그 설정
#   }
# }