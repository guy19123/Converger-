variable "environment" {
  description = "environment in which vpc will be created"
}

variable "cidr_block" {
  description = "cidr block to be used in vpc"
}

variable "public_subnets" {
  default     = []
  description = "list of public subnets"
}

variable "availability_zones" {
  default     = []
  description = "list of availability_zones to use"
}

variable "tags" {
  type    = map(any)
  default = {}
}
