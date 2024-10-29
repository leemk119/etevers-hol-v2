# RDS 인스턴스 생성
resource "aws_db_instance" "prod_db" {
  identifier        = "prod-main-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "mydb"
  username = "admin"
  password = var.db_password

  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.prod_db_subnet_group.name

  multi_az               = true
  skip_final_snapshot    = true
  backup_retention_period = 7

  tags = {
    Name = "prod-main-db"
  }
}

# DB 서브넷 그룹 생성
resource "aws_db_subnet_group" "prod_db_subnet_group" {
  name       = "prod-db-subnet-group"
  subnet_ids = aws_subnet.private_db[*].id

  tags = {
    Name = "prod-db-subnet-group"
  }
}

# DB 파라미터 그룹 생성
resource "aws_db_parameter_group" "prod_db_pg" {
  family = "mysql8.0"  # MySQL 8.0 파라미터 그룹 패밀리
  name   = "prod-db-pg"  # 파라미터 그룹 이름

  # 문자셋 및 콜레이션 설정
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"  # 유니코드 대소문자 구분 없는 정렬
  }

  # 성능 최적화 설정
  parameter {
    name  = "innodb_buffer_pool_size"
    value = "{DBInstanceClassMemory*3/4}"  # 인스턴스 메모리의 75%를 InnoDB 버퍼 풀로 설정
  }
  parameter {
    name  = "max_connections"
    value = "1000"  # 최대 동시 연결 수 증가
  }
  parameter {
    name  = "innodb_file_per_table"
    value = "1"  # 각 테이블을 별도의 파일로 저장 (관리 용이성 증가)
  }
  parameter {
    name  = "innodb_flush_log_at_trx_commit"
    value = "2"  # 성능과 안정성의 균형 (1: 가장 안전, 2: 절충, 0: 가장 빠름)
  }

  # 슬로우 쿼리 로그 설정
  parameter {
    name  = "slow_query_log"
    value = "1"  # 슬로우 쿼리 로깅 활성화
  }
  parameter {
    name  = "long_query_time"
    value = "2"  # 2초 이상 걸리는 쿼리를 슬로우 쿼리로 기록
  }

  # 시간대 설정
  parameter {
    name  = "time_zone"
    value = "Asia/Seoul"  # 한국 시간대로 설정
  }

  # 보안 관련 설정
  parameter {
    name  = "max_allowed_packet"
    value = "64194304"  # 최대 패킷 크기 64MB로 설정
  }

  # 트랜잭션 격리 수준 설정
  parameter {
    name  = "transaction_isolation"
    value = "READ-COMMITTED"  # 일반적인 애플리케이션에 적합한 격리 수준
  }

  tags = {
    Name = "prod-db-parameter-group"  # 리소스 태그 설정
  }
}