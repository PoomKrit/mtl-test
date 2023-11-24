module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.2.0"

  name = "${local.key_name}-vpc"
  cidr = var.cidr_block

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.nat_gateway

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

