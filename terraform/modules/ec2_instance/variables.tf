variable "env" {
  type    = string
  default = "dev"
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "workstation_ip" {
  type = string
}

variable "lb_rule" {
  type    = bool
  default = false
}

variable "private_ip" {
  type = string
}

variable "server_type" {
  type = string
}