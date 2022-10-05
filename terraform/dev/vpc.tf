module "vpc" {

  source             = "../modules/vpc"
  environment        = var.env
  cidr_block         = var.cidr_block
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
  tags = {
    Name        = "${var.env}-vpc"
    Environment = title(var.env)
    Region      = var.region
  }
}
