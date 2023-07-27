# Define an IAM Role resource named "pod_sa" for the Kubernetes Service Account.
resource "aws_iam_role" "pod_sa" {
  name = "podServiceAccountRole"  # Name of the IAM Role.

  # Specify the trust policy that allows the role to be assumed by the EKS service.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

# Define an IAM Policy resource named "s3_policy" for S3 bucket access.
resource "aws_iam_policy" "s3_policy" {
  name = "PodS3PolicyTest"  # Name of the IAM Policy.

  # Define the permissions of the IAM Policy.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:Get*",      # Allow Get operations on S3 objects.
          "s3:List*",     # Allow List operations on S3 objects.
          "s3:Put*",      # Allow Put operations on S3 objects.
          "s3:Delete*",   # Allow Delete operations on S3 objects.
        ]
        Resource = "arn:aws:s3:::*"  # Allow these actions on all S3 buckets (* denotes all buckets).
      }
    ]
  })
}

# Attach the IAM Policy to the IAM Role to grant S3 permissions to the Kubernetes Service Account.
resource "aws_iam_role_policy_attachment" "pod_policy" {
  policy_arn = aws_iam_policy.s3_policy.arn  # ARN of the IAM Policy to attach.
  role       = aws_iam_role.pod_sa.name      # Name of the IAM Role to which the policy will be attached.
}
