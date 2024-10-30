# Launch Template 생성
resource "aws_launch_template" "prod_web_lt" {
  name_prefix   = "prod-web-lt"
  image_id      = var.ec2_ami
  instance_type = var.ec2_instance_type
  key_name      = var.ec2_key_name

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = data.template_file.web_user_data.rendered

  # EBS 볼륨 설정
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp3"
      encrypted   = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "prod-web-instance"
    }
  }
}