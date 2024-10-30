## user_data.sh 참조##
data "template_file" "web_user_data" {
  template = filebase64("user_data.sh")
}