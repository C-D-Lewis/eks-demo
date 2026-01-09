provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "eks-demo-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "eks-demo-cluster"
  cluster_version = "1.31"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Enables the current user to act as cluster admin
  enable_cluster_creator_admin_permissions = true

  # Public API endpoint access for this demo project
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true # Optional, but good for node-to-control-plane talk

  eks_managed_node_groups = {
    demo_node = {
      instance_types = ["t3.medium"]
      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }
}