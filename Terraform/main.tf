provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

locals {
  common_tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
