variable "region" {
  default = "ap-south-1"
}

variable "client_name" {
  default = "clientA"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_app_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "private_db_subnet_cidr" {
  default = "10.0.3.0/24"
}

variable "instance_type" {
  default = "t3.micro"
}
