data "aws_ami" "mythreetire_frontend_ami" {
  most_recent = true
  owners = ["self"]

  filter {
    name = "name"
    values = ["frontend-ami"]
  }
}

#Launch Frontend Template Resource
resource "aws_launch_template" "mythreetire_launch_frontend" {
  name = "My-3-tire-Frontend-terraform"
  description = "frontend-terraform"

  image_id = data.aws_ami.mythreetire_frontend_ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.mythreetire_frontend_server_sg.id]
  key_name = "aws_key"
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name="Frontend-terraform"
    }
  }
}

# +++++++++++++++++++++++++++++++++++

data "aws_ami" "mythreetire_backendend_ami" {
  most_recent = true
  owners = ["self"]

  filter {
    name = "name"
    values = ["backend-ami"]
  }
}

#Launch Backend Template Resource
resource "aws_launch_template" "mythreetire_launch_backend" {
  name = "My-3-tire-Backend-terraform"
  description = "Backend-terraform"

  image_id = data.aws_ami.mythreetire_backendend_ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.mythreetire_backend_server_sg.id ]
  key_name = "aws_key"
  update_default_version = true
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Backend-Terraform"
    }
  }
}