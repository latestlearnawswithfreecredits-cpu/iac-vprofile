provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "aws" {
  region = var.region

  # AWS European Sovereign Cloud requires custom endpoints
  endpoints {
    ec2                  = "https://ec2.eusc-de-east-1.amazonaws.eu"
    eks                  = "https://eks.eusc-de-east-1.amazonaws.eu"
    sts                  = "https://sts.eusc-de-east-1.amazonaws.eu"
    iam                  = "https://iam.eusc-de-east-1.amazonaws.eu"
    elasticloadbalancing = "https://elasticloadbalancing.eusc-de-east-1.amazonaws.eu"
    kms                  = "https://kms.eusc-de-east-1.amazonaws.eu"
    logs                 = "https://logs.eusc-de-east-1.amazonaws.eu"
  }

  # Skip some validation that may cause issues with Sovereign Cloud
  skip_metadata_api_check    = true
  skip_region_validation     = true
  skip_requesting_account_id = false
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = var.clusterName
}

#####
