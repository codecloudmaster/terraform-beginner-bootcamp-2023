
#moved {
#	from = aws_s3_bucket.website_bucket
#	to   = module.terrahouse_aws.aws_s3_bucket.website_bucket
#  }
  
  module "terrahome_aws" {
	source = "./modules/terrahome_aws"
	for_each = local.homes_path_aws
	public_path = each.value.public_path
	#s3_bucket_name = var.s3_bucket_name
	user_uuid = var.teacherseat_user_uuid
	#index_html_filepath = each.value.public_path/index.html
	#error_html_filepath = var.error_html_filepath
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
  