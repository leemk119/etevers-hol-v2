# Auto Scaling Group 생성
resource "aws_autoscaling_group" "prod_web_asg" {
  name                = "prod-web-asg"
  vpc_zone_identifier = aws_subnet.private_web[*].id
  target_group_arns   = [aws_lb_target_group.prod_alb_tg.arn]
  health_check_type   = "ELB"

  min_size         = 1
  max_size         = 3
  desired_capacity = 2

  # Launch Template 연결
  launch_template {
    id      = aws_launch_template.prod_web_lt.id
    version = "$Latest"
  }

  # ASG 인스턴스 태그 설정
  tag {
    key                 = "Name"
    value               = "prod-web-asg-instance"
    propagate_at_launch = true
  }
}

# Auto Scaling 정책 (CPU 사용률 기반 스케일 아웃)
resource "aws_autoscaling_policy" "web_scale_out" {
  name                   = "web-scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.prod_web_asg.name
}

# CPU 사용률 높음 경보
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_high" {
  alarm_name          = "web-cpu-alarm-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.prod_web_asg.name
  }

  alarm_description = "This metric monitors EC2 CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.web_scale_out.arn]
}

# Auto Scaling 정책 (CPU 사용률 기반 스케일 인)
resource "aws_autoscaling_policy" "web_scale_in" {
  name                   = "web-scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.prod_web_asg.name
}

# CPU 사용률 낮음 경보
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_low" {
  alarm_name          = "web-cpu-alarm-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.prod_web_asg.name
  }

  alarm_description = "This metric monitors EC2 CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.web_scale_in.arn]
}