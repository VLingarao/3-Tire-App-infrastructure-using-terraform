#Create VPC
resource "aws_vpc" "mythreetire_vpc" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "My-3-tire-vpc"
  }
}

#For Frontend Load Balancer Subnet Public 1
resource "aws_subnet" "mythreetire_subnet_pub1" {
  vpc_id                  = aws_vpc.mythreetire_vpc.id
  cidr_block              = "172.20.1.0/24"
  availability_zone       = "ap-south-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Pub-1a"
  }
}

#For Frontend Load Balancer Subnet Public 2
resource "aws_subnet" "mythreetire_subnet_pub2" {
  vpc_id                  = aws_vpc.mythreetire_vpc.id
  cidr_block              = "172.20.2.0/24"
  availability_zone       = "ap-south-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Pub-2b"
  }
}

#For Frontend Server Subnet Private 3
resource "aws_subnet" "mythreetire_subnet_prvt3" {
  vpc_id            = aws_vpc.mythreetire_vpc.id
  cidr_block        = "172.20.3.0/24"
  availability_zone = "ap-south-2a"
  tags = {
    Name = "Prvt-3a"
  }
}

#For Frontend Server Subnet Private 4
resource "aws_subnet" "mythreetire_subnet_prvt4" {
  vpc_id            = aws_vpc.mythreetire_vpc.id
  cidr_block        = "172.20.4.0/24"
  availability_zone = "ap-south-2b"
  tags = {
    Name = "Prvt-4b"
  }
}

#Backend Server Subnet Private 5
resource "aws_subnet" "mythreetire_subnet_prvt5" {
  vpc_id            = aws_vpc.mythreetire_vpc.id
  cidr_block        = "172.20.5.0/24"
  availability_zone = "ap-south-2a"
  tags = {
    Name = "Prvt-5a"
  }
}

#Backend Server Subnet Private 6
resource "aws_subnet" "mythreetire_subnet_prvt6" {
  vpc_id            = aws_vpc.mythreetire_vpc.id
  cidr_block        = "172.20.6.0/24"
  availability_zone = "ap-south-2b"
  tags = {
    Name = "Prvt-6b"
  }
}

#RDS Subnet Private 7
resource "aws_subnet" "mythreetire_subnet_prvt7" {
  vpc_id            = aws_vpc.mythreetire_vpc.id
  cidr_block        = "172.20.7.0/24"
  availability_zone = "ap-south-2a"
  tags = {
    Name = "Prvt-7a"
  }
}

#RDS Subnet Private 8
resource "aws_subnet" "mythreetire_subnet_prvt8" {
  vpc_id            = aws_vpc.mythreetire_vpc.id
  cidr_block        = "172.20.8.0/24"
  availability_zone = "ap-south-2b"
  tags = {
    Name = "Prvt-8b"
  }
}

#Create Internet Gateway
resource "aws_internet_gateway" "mythreetire_ig" {
  vpc_id = aws_vpc.mythreetire_vpc.id
  tags = {
    Name = "My-3-tire-Ig"
  }
}

#Create Public Route Table
resource "aws_route_table" "mythreetire_pub_rt" {
  vpc_id = aws_vpc.mythreetire_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mythreetire_ig.id
  }
  tags = {
    Name = "My-3-tire-Pub-Rt"
  }
}

#Attaching Public 1a Subnet to Public route table
resource "aws_route_table_association" "mythreetire_pub_rt_ass_2a" {
  route_table_id = aws_route_table.mythreetire_pub_rt.id
  subnet_id      = aws_subnet.mythreetire_subnet_pub1.id
}

#Attaching Public 2b Subnet to Public route table
resource "aws_route_table_association" "mythreetire_pub_rt_ass_2b" {
  route_table_id = aws_route_table.mythreetire_pub_rt.id
  subnet_id      = aws_subnet.mythreetire_subnet_pub2.id
}

#Creating Elastic ip for Nat Gateway
resource "aws_eip" "mythreetire_eip" {
  domain = "vpc"
  
  depends_on = [aws_internet_gateway.mythreetire_ig]
}

#Creating Nat Gateway
resource "aws_nat_gateway" "mythreetire_ngw" {
  subnet_id         = aws_subnet.mythreetire_subnet_pub1.id
  connectivity_type = "public"
  allocation_id     = aws_eip.mythreetire_eip.id
  depends_on        = [aws_internet_gateway.mythreetire_ig]
  tags = {
    Name = "My-3-tire-Nat-Gate-Way"
  }
}

#Create Private Route Table
resource "aws_route_table" "mythreetire_prvt_rt" {
  vpc_id = aws_vpc.mythreetire_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.mythreetire_ngw.id
  }
  tags = {
    Name = "My-3-tire-Prvt-Rt"
  }
}

#Attaching Private 3a Subnet to Private route table
resource "aws_route_table_association" "mythreetire_prvt_rt_ass_3a" {
  route_table_id = aws_route_table.mythreetire_prvt_rt.id
  subnet_id      = aws_subnet.mythreetire_subnet_prvt3.id
}

#Attaching Private 4b Subnet to Private route table
resource "aws_route_table_association" "mythreetire_prvt_rt_ass_4b" {
  route_table_id = aws_route_table.mythreetire_prvt_rt.id
  subnet_id      = aws_subnet.mythreetire_subnet_prvt4.id
}

#Attaching Private 5a Subnet to Private route table
resource "aws_route_table_association" "mythreetire_prvt_rt_ass_5a" {
  route_table_id = aws_route_table.mythreetire_prvt_rt.id
  subnet_id      = aws_subnet.mythreetire_subnet_prvt5.id
}

#Attaching Private 6b Subnet to Private route table
resource "aws_route_table_association" "mythreetire_prvt_rt_ass_6b" {
  route_table_id = aws_route_table.mythreetire_prvt_rt.id
  subnet_id      = aws_subnet.mythreetire_subnet_prvt6.id
}

#Attaching Private 7a Subnet to Private route table
resource "aws_route_table_association" "mythreetire_prvt_rt_ass_7a" {
  route_table_id = aws_route_table.mythreetire_prvt_rt.id
  subnet_id      = aws_subnet.mythreetire_subnet_prvt7.id
}

#Attaching Private 8b Subnet to Private route table
resource "aws_route_table_association" "mythreetire_prvt_rt_ass_8b" {
  route_table_id = aws_route_table.mythreetire_prvt_rt.id
  subnet_id      = aws_subnet.mythreetire_subnet_prvt8.id
}

#-------------------------------Networking Layer (VPC Layer) Completed----------------------------------------#
