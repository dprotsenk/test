# Define the Helm provider to interact with the Kubernetes cluster using Helm.
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint  # Set the Kubernetes API server host using the EKS cluster endpoint.
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)  # Decode the cluster CA certificate for secure communication.

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"  # Specify the API version for executing commands.
      command     = "aws"  # The command to be executed for authentication.
      args        = ["eks", "get-token", "--cluster-name", "testtask-cluster"]  # Arguments for the authentication command.
    }
  }
}

# Commented out resource for creating a Helm release of the web application.
# resource "helm_release" "webapp" {
#   name  = "webapp-test"  # The name of the Helm release.
#   chart = "./webapp-service/helm_chart"  # Path to the Helm chart directory.
# }
