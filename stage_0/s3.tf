provider "aws" {
  region     = "eu-central-1"
}

# Create an S3 bucket for Terraform state - Stage 1
resource "aws_s3_bucket" "stage_1_terraform_state_bucket" {
  bucket = "tf-state-bucket-stage-1-eu-central-1"

  tags = {
    Name = "Terraform State Bucket - Stage 1"
    Environment = "stage_1"
  }
}

# Configure the S3 bucket to store Terraform state - Stage 1
resource "aws_s3_object" "stage_1_terraform_state_bucket_policy" {
  bucket = aws_s3_bucket.stage_1_terraform_state_bucket.bucket
  key    = "terraform.tfstate"

  acl          = "private"
  content_type = "text/plain"

  # Prevent accidental deletion of the state file
  lifecycle {
    prevent_destroy = true
  }
}

# Outputs
output "stage_1_bucket_name" {
  value = aws_s3_bucket.stage_1_terraform_state_bucket.bucket
}
