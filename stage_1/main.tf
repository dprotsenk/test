# Specify the Terraform backend configuration for storing the state file in an S3 bucket.
# This allows multiple team members to collaborate and maintain state remotely.
terraform {
  backend "s3" {
    bucket = "tf-state-bucket-stage-1-eu-central-1"  # Name of the S3 bucket to store the state file.
    key    = "terraform.tfstate"  # Name of the state file within the S3 bucket.
    region = "eu-central-1"  # AWS region where the S3 bucket is located.
  }
  required_version = ">= 0.13.7"  # Specify the minimum required Terraform version for this configuration.
}

# Define the AWS provider configuration to manage resources in the "us-east-1" region.
provider "aws" {
  region = "us-east-1"  # The AWS region to be used for resource creation and management.
}
