resource "aws_security_group" "ec2-sg" {
  name   = "${var.server_type}-${var.env}-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "allowing inbound over SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.workstation_ip}/32"]
  }

  ingress {
    description = "allowing all traffic in VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.server_type}-${var.env}-sg"
  }
}

resource "aws_security_group_rule" "lb-sg-rule" {
  count       = var.lb_rule ? 1 : 0
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["${var.workstation_ip}/32"]
  security_group_id = aws_security_group.ec2-sg.id
}

resource "aws_network_interface" "ec2_ineterface" {
  subnet_id   = var.subnet_id
  private_ips = [var.private_ip]
  security_groups = [ aws_security_group.ec2-sg.id ]

  tags = {
    Name = "primary_network_interface"
  }
}


resource "aws_instance" "ec2_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  network_interface {
    network_interface_id = aws_network_interface.ec2_ineterface.id
    device_index = 0
  }
  # vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  tags = {
    Name = "${var.server_type}-${var.env}-ec2"
  }
}