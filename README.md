# Automate EKS cluster setup on AWS


You've joined a new and growing startup.

The company wants to build its initial Kubernetes infrastructure on AWS.

They have asked you if you can help create the following:

Terraform code that deploys an EKS cluster (whatever latest version is currently available) into an existing VPC
The terraform code should also prepare anything needed for a pod to be able to assume an IAM role
Include a short readme that explains how to use the Terraform repo and that also demonstrates how an end-user (a developer from the company) can run a pod on this new EKS cluster and also have an IAM role assigned that allows that pod to access an S3 bucket.

## How to

1. Change directory to `stage_1`

2. Read `README.md` file.

# Managing secrets on Kubernetes

### Option 1: Use AWS Secrets Manager

1. AWS Secrets Manager is a managed service provided by Amazon Web Services (AWS) designed to securely store and manage secrets.
2. It encrypts secrets at rest and in transit, ensuring data security.
3. Provides fine-grained access control, allowing the client to set access permissions for who can retrieve the stored secrets.
4. Offers automatic rotation of credentials, enhancing security by regularly changing sensitive information.
5. Seamless integration with Kubernetes running on AWS EKS, enabling secure access to secrets from pods.

### Option 2: Use Kubernetes Secrets

1. Kubernetes has a built-in feature called "Secrets" for securely managing sensitive data within Kubernetes clusters.
2. Kubernetes Secrets are natively integrated into Kubernetes, enabling easy management of sensitive data within the cluster.
3. Secret data in Kubernetes is automatically encrypted and decoded at the pod level.
4. Kubernetes Secrets can be used as environment variables or mounted as files within pods, providing flexibility in accessing secret data.

Both options aim to improve secret management practices and reduce the risk of exposing sensitive data. The client can choose the option that best suits their needs and aligns with their team's capabilities. Educating the team on best practices for secret management and access control is essential to maintaining a secure environment. Proper setup of IAM roles and permissions is also necessary to control access to AWS Secrets Manager or Kubernetes Secrets.