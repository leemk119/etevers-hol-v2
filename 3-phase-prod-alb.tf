# # Application Load Balancer 생성
# resource "aws_lb" "prod_alb" {
#   name               = "prod-web-alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.alb_sg.id]
#   subnets            = aws_subnet.public[*].id

#   enable_deletion_protection = false

#   tags = {
#     Name = "prod-web-alb"
#   }
# }

# # ALB 리스너 생성
# resource "aws_lb_listener" "prod_alb_listener" {
#   load_balancer_arn = aws_lb.prod_alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.prod_alb_tg.arn
#   }
# }

# # ALB 타겟 그룹 생성
# resource "aws_lb_target_group" "prod_alb_tg" {
#   name     = "prod-web-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.prod_vpc.id

#   health_check {
#     enabled             = true
#     interval            = 30
#     path                = "/"
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#   }
# }

# # 타겟 그룹에 인스턴스 연결
# resource "aws_lb_target_group_attachment" "prod_alb_tg_attachment" {
#   count            = length(aws_instance.web)
#   target_group_arn = aws_lb_target_group.prod_alb_tg.arn
#   target_id        = aws_instance.web[count.index].id
#   port             = 80
# }