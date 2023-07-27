# Define a Kubernetes Deployment resource named "testpod" to manage the deployment of pods.
resource "kubernetes_deployment" "testpod" {
  metadata {
    name      = "testpod"    # Name of the Deployment.
    namespace = "default"    # Namespace where the Deployment will be created.
  }

  spec {
    replicas = 1  # Number of desired replicas of the pods to be deployed.

    selector {
      match_labels = {
        app = "testpod"  # Selector to match labels for the pods managed by this Deployment.
      }
    }

    template {
      metadata {
        labels = {
          app = "testpod"  # Labels for the pods managed by this Deployment.
        }
      }

      spec {
        service_account_name = kubernetes_service_account.pod_sa.metadata[0].name  # Use the specified Service Account for the pods.

        container {
          image = "nginx:latest"  # Docker image to use for the container.
          name  = "testpod"       # Name of the container within the pod.
        }
      }
    }
  }
}
