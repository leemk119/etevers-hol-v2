# # 웹 서버 EC2 인스턴스 생성
# resource "aws_instance" "web" {
#   count         = 2  # 2개의 인스턴스 생성
#   ami           = var.ec2_ami
#   instance_type = var.ec2_instance_type
#   key_name      = var.ec2_key_name
#   subnet_id     = aws_subnet.private_web[count.index].id

#   vpc_security_group_ids = [aws_security_group.web_sg.id]

#   # 사용자 데이터 스크립트 사용
#   user_data = <<-EOF
#               #!/bin/bash
#               sudo dnf update -y
#               sudo dnf install httpd -y
#               sudo systemctl start httpd
#               sudo systemctl enable httpd
#               echo "<html><body><h1>Hello, ETEVERS IaC HoL!</h1></body></html>" | sudo tee /usr/share/httpd/noindex/index.html
#               EOF

#   tags = {
#     Name = "prod-web-instance-${count.index + 1}"
#   }

#   root_block_device {
#     volume_type = "gp3"
#     volume_size = 30
#     encrypted   = true
#   }
# }