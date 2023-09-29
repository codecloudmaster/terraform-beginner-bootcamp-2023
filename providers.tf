terraform {

  cloud {
    organization = "ITCrowd"

    workspaces {
      name = "terra-house-1"
    }
  }


  required_providers {
    
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }

  }
}

provider "aws" {
  # Configuration options
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"

  s3_bucket_name = var.s3_bucket_name
  user_uuid = var.user_uuid
    
}



