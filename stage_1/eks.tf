# Define the Kubernetes provider to interact with the EKS cluster.
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint  # Set the Kubernetes API server host using the EKS cluster endpoint.
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)  # Decode the cluster CA certificate for secure communication.

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"  # Specify the API version for executing commands.
    command     = "aws"  # The command to be executed for authentication.
    args        = ["eks", "get-token", "--cluster-name", "testtask-cluster"]  # Arguments for the authentication command.
  }
}

# Define the EKS cluster using the terraform-aws-modules/eks/aws module.
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.15.3"

  cluster_name                    = "testtask-cluster"  # Name of the EKS cluster.
  cluster_version                 = "1.27"  # Kubernetes version to use for the cluster.
  cluster_endpoint_private_access = true  # Enable private access to the cluster endpoint.
  cluster_endpoint_public_access  = true  # Enable public access to the cluster endpoint.

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"  # Set the conflict resolution strategy for the CoreDNS addon.
    }
  }

  vpc_id     = module.vpc.vpc_id  # ID of the VPC where the EKS cluster should be created.
  subnet_ids = module.vpc.private_subnets  # List of private subnet IDs within the VPC.

  manage_aws_auth_configmap = true  # Enable management of the AWS auth ConfigMap.

  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true  # Allow egress to nodes from their security group.
    }
  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      protocol  = "-1"
      from_port = 0
      to_port   = 0
      type      = "ingress"
      self      = true  # Allow nodes to communicate with each other.
    }

    egress_all = {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]  # Allow egress traffic to any destination.
    }
  }

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"  # Amazon Linux 2 AMI type.
    disk_size      = 50  # Root volume size in GB.
    instance_types = ["t3.small"]  # Instance types for the managed node groups.
  }

  eks_managed_node_groups = {
    default_node_group = {
      min_size       = 4  # Minimum number of nodes in the node group.
      max_size       = 4  # Maximum number of nodes in the node group.
      desired_size   = 4  # Desired number of nodes in the node group.
      instance_types = ["t3.small"]  # Instance types for the default node group.
    }
  }
}
