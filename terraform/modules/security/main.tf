#################################
# Web Security Group
#################################

resource "aws_security_group" "web_sg" {
  name        = "${var.client_name}-web-sg"
  description = "Web tier security group"
  vpc_id      = var.vpc_id

  # Allow HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH only from your IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["13.233.232.188/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#################################
# App Security Group
#################################

resource "aws_security_group" "app_sg" {
  name        = "${var.client_name}-app-sg"
  description = "App tier security group"
  vpc_id      = var.vpc_id

  # Allow traffic only from Web SG
  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  # Optional SSH (can remove in prod)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["13.233.232.188/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#################################
# DB Security Group
#################################

resource "aws_security_group" "db_sg" {
  name        = "${var.client_name}-db-sg"
  description = "DB tier security group"
  vpc_id      = var.vpc_id

  # Allow MySQL only from App SG
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  # Optional SSH (can remove in prod)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["13.233.232.188/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
