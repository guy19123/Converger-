data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_ssh_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

module "lb_ec2" {
  source         = "../modules/ec2_instance"
  env            = var.env
  key_name       = var.key_name
  ami            = data.aws_ami.ubuntu.id
  instance_type  = var.instance_type
  vpc_id         = module.vpc.vpc_id
  vpc_cidr       = var.cidr_block
  subnet_id      = module.vpc.public_subnet_ids[0][0]
  private_ip     = "192.168.0.11"
  workstation_ip = var.workstation_ip
  lb_rule        = true
  server_type    = "lb"
}

module "web_ec2" {
  source         = "../modules/ec2_instance"
  env            = var.env
  key_name       = var.key_name
  ami            = data.aws_ami.ubuntu.id
  instance_type  = var.instance_type
  vpc_id         = module.vpc.vpc_id
  vpc_cidr       = var.cidr_block
  subnet_id      = module.vpc.public_subnet_ids[0][0]
  private_ip     = "192.168.0.12"
  workstation_ip = var.workstation_ip
  server_type    = "web"
}

module "db_ec2" {
  source         = "../modules/ec2_instance"
  env            = var.env
  key_name       = var.key_name
  ami            = data.aws_ami.ubuntu.id
  instance_type  = var.instance_type
  vpc_id         = module.vpc.vpc_id
  vpc_cidr       = var.cidr_block
  subnet_id      = module.vpc.public_subnet_ids[0][0]
  private_ip     = "192.168.0.13"
  workstation_ip = var.workstation_ip
  server_type    = "db"
}