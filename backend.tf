## tfstate를 저장할 backend 설정 ##
terraform {
  backend "local" {
  path = "state/terraform.tfstate"
  }
}

# S3 백엔드를 사용하려면 아래 설정을 사용하고 위의 local 백엔드를 주석 처리하세요.
# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"
#     key            = "prod/terraform.tfstate"
#     region         = "ap-northeast-2"
#     encrypt        = true
#     dynamodb_table = "terraform-lock-table"
#   }
# }


# 1. 로컬 백엔드 설정:
#    - 현재 구성은 로컬 파일 시스템에 상태 파일을 저장합니다.
#    - 상태 파일은 "state/terraform.tfstate" 경로에 저장됩니다.

# 2. S3 백엔드 설정 (주석 처리됨):
#    - 프로덕션 환경에서는 S3를 사용하여 상태 파일을 저장하는 것이 좋습니다.
#    - S3 버킷 이름, 키, 리전을 지정합니다.
#    - 상태 파일 암호화를 활성화합니다.
#    - DynamoDB 테이블을 사용하여 상태 잠금을 구현할 수 있습니다.

# 백엔드 구성의 중요성:

# - 상태 관리: Terraform은 이 상태 파일을 사용하여 현재 인프라 상태를 추적합니다.
# - 협업: 원격 백엔드(예: S3)를 사용하면 팀 구성원 간에 상태를 공유할 수 있습니다.
# - 보안: S3 백엔드를 사용하면 상태 파일을 암호화하고 접근을 제어할 수 있습니다.
# - 동시성 제어: DynamoDB를 사용한 상태 잠금은 여러 사용자가 동시에 변경하는 것을 방지합니다.

# 현재 구성은 로컬 백엔드를 사용하고 있지만, 프로덕션 환경에서는 S3 백엔드로 전환하는 것이 좋습니다. 
# S3 백엔드로 전환하려면 주석 처리된 부분의 주석을 해제하고, 적절한 S3 버킷 이름과 DynamoDB 테이블 이름을 지정해야 합니다.