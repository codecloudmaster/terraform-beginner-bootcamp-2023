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
  
module "terrahome_aws" {
  source = "./modules/terrahome_aws"
  for_each = local.homes_path_aws
  public_path = each.value.public_path
  user_uuid = var.teacherseat_user_uuid
  content_version = each.value.content_version
} 

resource "terratowns_home" "home" {
  for_each = local.homes
  name = each.value.name
  description = each.value.description
  domain_name = each.value.domain_name
  town = each.value.town
  content_version = each.value.content_version
}
  