terraform {

  cloud {
    organization = "ITCrowd"
    workspaces {
      name = "terra-house-1"
    }
  }


  required_providers {
    
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }

    
    aws = {
      source = "hashicorp/aws"
      version = "5.21.0"
    }

  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token=var.terratowns_access_token
  
}


#provider "aws" {
#  # Configuration options
#}



