resource "aws_instance" "mythreetire_bs_ec2_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.mythreetire_subnet_pub1.id
  vpc_security_group_ids = [aws_security_group.mythreetire_bs_sg.id]
  depends_on             = [aws_vpc.mythreetire_vpc, aws_subnet.mythreetire_subnet_pub1, aws_security_group.mythreetire_bs_sg]
  tags = {
    Name = "My-3-tire-Bs-ec2-Server"
  }
}
