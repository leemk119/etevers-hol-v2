# ETEVERS Hands-On Lab v2 feat. Terraform

## 🗂️ 테라폼을 이용한 AWS 3-Tier 인프라 폴더 구조

```bash
.
├── 1-phase-prod-vpc.tf         # VPC 구성
├── 2-phase-prd-sg.tf           # 게이트웨이 및 라우팅 테이블 설정
├── 2-phase-prod-gw_rt.tf       # 보안 그룹 설정
├── 3-phase-prod-alb.tf         # ALB (Application Load Balancer) 설정
├── 4-phase-prod-ec2-web.tf     # EC2 웹 서버 구성
├── 5-phase-prod-rds-db.tf      # RDS 데이터베이스 구성
├── 6-phase-prod-LT.tf          # Launch Template 설정
├── 6-phase-prod-asg.tf         # Auto Scaling Group 설정
├── backend.tf                  # 백엔드 설정 파일
├── output.tf                   # Terraform 실행 후 리소스 ID 출력 정보
├── terraform.tfvars            # 민감정보 정의
├── user_data.sh                # EC2 인스턴스 시작 시 실행될 셸 스크립트
├── user_data.tf                # EC2 인스턴스 시작 시 실행될 사용자 데이터 스크립트
└── variables.tf                # Terraform 구성에서 사용될 변수들을 정의