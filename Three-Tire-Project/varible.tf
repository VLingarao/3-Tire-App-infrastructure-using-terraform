variable "ami" {
  description = "ami"
  type = string
  default = "ami-07a65c5821dc8290c"
}

variable "instance_type" {
  description = "instance-type"
  type = string
  default = "t3.micro"
}

variable "key_name" {
  description = "key name"
  type = string
  default = "aws_key"
}

variable "rds-username" {
  description = "rds username"
  type = string
  default = "admin"
}

variable "rds-password" {
  description = "rds password"
  type = string
  default = "myawsrds1120"
}

variable "db-name" {
  description = "Data Base Name"
  type = string
  default = "bikedb"
}