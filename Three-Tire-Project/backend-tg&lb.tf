resource "aws_lb_target_group" "backend_tg" {
  name     = "backend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.mythreetire_vpc.id
  depends_on = [aws_vpc.mythreetire_vpc]

  health_check {
    path = "/"
    port = "80"
    protocol = "HTTP"
  }
}


resource "aws_lb" "backend_alb" {
  name               = "backend-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.mythreetire_alb_backend_sg.id
  ]

  subnets = [
    aws_subnet.mythreetire_subnet_pub1.id,
    aws_subnet.mythreetire_subnet_pub2.id
  ]

  tags = {
    Name = "ALB-Backend"
  }
  depends_on = [aws_lb_target_group.backend_tg]
}


resource "aws_lb_listener" "backend_lb_li" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
  depends_on = [aws_lb_target_group.backend_tg]
}
