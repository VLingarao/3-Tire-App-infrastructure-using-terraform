#Create bastion SG
resource "aws_security_group" "mythreetire_bs_sg" {
    name = "My-3-tire-appserver-Bs-Sg"
    description = "Allow inbound traffic from ALB"
    vpc_id = aws_vpc.mythreetire_vpc.id
    depends_on = [ aws_vpc.mythreetire_vpc ]

    ingress{
        description = "Allow traffic from web layer"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "My-3-tire-Bs-Sg"
    }
}

#Create ALB Frontend SG
resource "aws_security_group" "mythreetire_alb_frontend_sg" {
  name = "alb-frontend-sg"
  description = "Allow inbound traffic from ALB"
  vpc_id = aws_vpc.mythreetire_vpc.id
  depends_on = [ aws_vpc.mythreetire_vpc ]

  ingress{
    description = "http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    description = "https"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "My-3-tire-Frontend-alb-Sg"
    }
}

#Create ALB Backend SG
resource "aws_security_group" "mythreetire_alb_backend_sg" {
  name = "alb-backend-sg"
  vpc_id = aws_vpc.mythreetire_vpc.id
  description = "Allows inbound traffic ALB"
  depends_on = [ aws_vpc.mythreetire_vpc ]

  ingress {
    description = "http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    description = "https"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "My-3-tire-Backend-alb-Sg"
  }
}

#Create Frontend Server SG
resource "aws_security_group" "mythreetire_frontend_server_sg" {
  name = "frontend-server-sg"
  description = "Allow inbound traffic"
  vpc_id = aws_vpc.mythreetire_vpc.id
  depends_on = [ aws_vpc.mythreetire_vpc,aws_security_group.mythreetire_alb_frontend_sg ]
  
  ingress{
    description = "http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.mythreetire_alb_frontend_sg.id]

  }
  ingress{
    description = "https"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.mythreetire_alb_frontend_sg.id]

  }

  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My-3-tire-Server-Frontend-Sg"
  }
}

#Create Backend Server SG
resource "aws_security_group" "mythreetire_backend_server_sg" {
  name        = "backend-server-sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.mythreetire_vpc.id
  depends_on = [ aws_vpc.mythreetire_vpc,aws_security_group.mythreetire_alb_backend_sg]

 ingress {
    description     = "http"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
      security_groups = [aws_security_group.mythreetire_alb_backend_sg.id]
  }
  ingress {
    description     = "ssh"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
    security_groups = [aws_security_group.mythreetire_bs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My-3-tire-Server-Backend-Sg"
  }
}

#Create RDS SG
resource "aws_security_group" "mythreetire_rds_server_sg" {
  name        = "book-rds-sg"
  description = "Allow inbound "
  vpc_id      = aws_vpc.mythreetire_vpc.id
  depends_on = [ aws_vpc.mythreetire_vpc ]

 ingress {
    description     = "mysql/aroura"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.mythreetire_backend_server_sg.id]
 }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My-3-tire-Server-RDS-Sg"
  }
}