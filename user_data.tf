## user_data.sh 참조##
data "template_file" "web_user_data" {
  template = filebase64("user_data.sh")
}

# 1. 사용자 데이터 스크립트를 별도의 파일로 관리할 수 있어 유지보수가 용이합니다.
# 2. 동일한 스크립트를 다른 리소스에서도 재사용할 수 있습니다.
# 3. 스크립트 내용을 변경할 때 Launch Template을 수정하지 않아도 됩니다.

# 이렇게 수정하면 기존에 작성된 user_data.sh 스크립트를 Launch Template에서 사용할 수 있습니다.