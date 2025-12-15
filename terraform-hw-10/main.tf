# S3 backend module
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "terraform-state-bucket-001001-us-east-1"
  table_name  = "terraform-locks"
}

# Підключаємо модуль VPC
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_name           = "lesson-8-9-vpc"
}

# Підключаємо модуль ECR
module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-8-9-ecr"
  scan_on_push = true
}

# Підключаємо модуль EKS
module "eks" {
  source       = "./modules/eks"
  cluster_name = "eks-cluster-demo"        # Назва кластера
  subnet_ids   = module.vpc.public_subnets # ID підмереж
}

data "aws_eks_cluster" "this" {
  name       = module.eks.eks_cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "this" {
  name       = module.eks.eks_cluster_name
  depends_on = [module.eks]
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  token                  = data.aws_eks_cluster_auth.this.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    token                  = data.aws_eks_cluster_auth.this.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  }
}


# Jenkins module (Helm release)
module "jenkins" {
  source    = "./modules/jenkins"
  namespace = "jenkins"

  depends_on = [module.eks]
}

# ArgoCD module (Helm release)
module "argo_cd" {
  source              = "./modules/argo_cd"
  namespace           = "argo-cd"
  helm_chart_repo_url = "https://argoproj.github.io/argo-helm"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }

  depends_on = [module.eks]
}

module "rds" {
  source = "./modules/rds"

  use_aurora                        = true
  engine                             = "postgres"
  engine_version                     = "15.7"
  instance_class                     = "db.t3.medium"
  multi_az                            = false
  username                            = "myapp_admin"
  password                            = "yourStrongPassword123"
  subnet_ids                          = module.vpc.private_subnets
  vpc_id                              = module.vpc.vpc_id
  allowed_cidr                        = "10.0.0.0/16"
  tags                                = { Environment = "dev" }
  name                                = "myapp"
}
