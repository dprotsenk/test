# Define a Kubernetes Service Account resource named "pod_sa".
resource "kubernetes_service_account" "pod_sa" {
  # Set metadata for the service account.
  metadata {
    name      = "pod-assume-role-account"  # Name of the service account.
    namespace = "default"  # Namespace where the service account will be created.

    # Annotations provide additional metadata to the service account.
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.pod_sa.arn  # Annotation to associate an IAM role with the service account.
    }
  }
}
