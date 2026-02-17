data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = "Arihant-jain"

  tags = {
    Name = "${var.client_name}-web"
  }
}

resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id = var.private_app_subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids = [var.app_sg_id]
  key_name               = "Arihant-jain"

  tags = {
    Name = "${var.client_name}-app"
  }
}

resource "aws_instance" "db" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id = var.private_db_subnet_id  
  associate_public_ip_address = false
  vpc_security_group_ids = [var.db_sg_id]
  key_name               = "Arihant-jain"

  tags = {
    Name = "${var.client_name}-db"
  }
}
