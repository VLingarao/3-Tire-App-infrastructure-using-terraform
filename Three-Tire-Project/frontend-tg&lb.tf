resource "aws_lb_target_group" "frontend_tg" {
    name = "frontend-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.mythreetire_vpc.id
    depends_on = [aws_vpc.mythreetire_vpc]
}

resource "aws_lb" "frontend_alb" {
    name = "frontend-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.mythreetire_alb_frontend_sg.id]
    subnets = [aws_subnet.mythreetire_subnet_pub1.id, aws_subnet.mythreetire_subnet_pub2.id]

    tags = {
        Name = "ALB-Frontend"
    }
    depends_on = [aws_lb_target_group.frontend_tg]
}

resource "aws_lb_listener" "frontend_lb_li" {
    load_balancer_arn = aws_lb.frontend_alb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.frontend_tg.arn
    }
    depends_on = [aws_lb_target_group.frontend_tg]
}