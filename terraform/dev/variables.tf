variable "env" {
  type    = string
  default = "dev"
}


variable "region" {
  type    = string
  default = "us-east-1"
}


variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "workstation_ip" {
  type = string
}

variable "key_name" {
  type    = string
  default = "ec2_key"
}

variable "cidr_block" {
  type    = string
  default = "192.168.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["192.168.0.0/18", "192.168.64.0/18", "192.168.128.0/18"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}


