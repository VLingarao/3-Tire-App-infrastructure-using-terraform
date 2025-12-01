resource "aws_autoscaling_group" "mythreetire_frontend_asg" {
  name_prefix         = "frontend-asg"
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.mythreetire_subnet_prvt3.id, aws_subnet.mythreetire_subnet_prvt4.id]

  health_check_type = "EC2"

  launch_template {
    id      = aws_launch_template.mythreetire_launch_frontend.id
    version = aws_launch_template.mythreetire_launch_frontend.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = [/*"launch_template",*/ "desired_capacity"]
  }
  tag {
    key                 = "Name"
    value               = "frontend-asg"
    propagate_at_launch = true
  }
}

##################################################################

resource "aws_autoscaling_group" "mythreetire_backend_asg" {
  name_prefix = "backend-asg"
  desired_capacity = 1
  max_size = 1
  min_size = 1
  vpc_zone_identifier = [aws_subnet.mythreetire_subnet_prvt5.id, aws_subnet.mythreetire_subnet_prvt6.id]
  target_group_arns = [ aws_lb_target_group.backend_tg.arn ]

  health_check_type = "EC2"

  launch_template {
    id = aws_launch_template.mythreetire_launch_backend.id
    version = aws_launch_template.mythreetire_launch_backend.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = [/*"launch_template" ,*/ "desired_capacity"]
  }
  tag {
    key = "Name"
    value = "backend-asg"
    propagate_at_launch = true
  }
}