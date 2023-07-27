terraform {
  backend "s3" {
    bucket = "tf-state-bucket-stage-1-eu-central-1"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
  required_version = ">= 0.13.7"
}

provider "aws" {
  region = "us-east-1"
}
