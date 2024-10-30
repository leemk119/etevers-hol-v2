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