# Define a variable to specify the AWS region for the resources.
variable "region" {
  description = "AWS region for the resources."
  default     = "eu-central-1"
}

# Define a variable to specify the CIDR block for the VPC.
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

# Define a variable to specify a list of CIDR blocks for public subnets.
variable "public_subnet_cidr_blocks" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Define a variable to specify a list of CIDR blocks for private subnets.
variable "private_subnet_cidr_blocks" {
  description = "List of CIDR blocks for private subnets."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}
