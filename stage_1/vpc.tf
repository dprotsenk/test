# Define a Terraform module named "vpc" sourced from "terraform-aws-modules/vpc/aws" with version 5.1.1
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.1.1"

  # Set the name and CIDR block for the VPC
  name = "testtask-cluster"
  cidr = "10.5.0.0/16"

  # Define the availability zones and corresponding private and public subnets
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.5.1.0/24", "10.5.2.0/24"]
  public_subnets  = ["10.5.3.0/24", "10.5.4.0/24"]

  # Enable NAT gateway and DNS hostname resolution
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  # Tags for the public subnets, used for identifying Kubernetes resources
  public_subnet_tags = {
    "kubernetes.io/cluster/testtask-cluster" = "shared"
    "kubernetes.io/role/elb"                 = 1
  }

  # Tags for the private subnets, used for identifying internal Kubernetes resources
  private_subnet_tags = {
    "kubernetes.io/cluster/testtask-cluster" = "shared"
    "kubernetes.io/role/internal-elb"        = 1
  }
}
