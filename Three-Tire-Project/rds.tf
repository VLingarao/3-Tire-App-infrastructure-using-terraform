resource "aws_db_subnet_group" "mythreetire_sub_grp" {
  name       = "main"
  subnet_ids = [aws_subnet.mythreetire_subnet_prvt7.id, aws_subnet.mythreetire_subnet_prvt8.id]
  depends_on = [aws_subnet.mythreetire_subnet_prvt7, aws_subnet.mythreetire_subnet_prvt8]

  tags = {
    Name = "My DB Subnet Group"
  }
}

resource "aws_db_instance" "mythreetire_rds" {
  allocated_storage       = 20
  identifier              = "book-rds"
  db_subnet_group_name    = aws_db_subnet_group.mythreetire_sub_grp.id
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  multi_az                = true
  db_name                 = var.db-name
  username                = var.rds-username
  password                = var.rds-password
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.mythreetire_rds_server_sg.id]
  depends_on              = [aws_db_subnet_group.mythreetire_sub_grp]
  publicly_accessible     = false
  backup_retention_period = 7

  tags = {
    DB_identifier = "book-rds"
  }
}
