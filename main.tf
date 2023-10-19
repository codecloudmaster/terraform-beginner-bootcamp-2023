
moved {
	from = aws_s3_bucket.website_bucket
	to   = module.terrahouse_aws.aws_s3_bucket.website_bucket
  }
  
  module "terrahouse_aws" {
	source = "./modules/terrahouse_aws"
	s3_bucket_name = var.s3_bucket_name
	user_uuid = var.user_uuid
	index_html_filepath = var.index_html_filepath
	error_html_filepath = var.error_html_filepath
	content_version = var.content_version
	assets_path = var.assets_path
  }
  

  resource "terratowns_home" "home" {
	name = "How to play Arcnanum in 2023"
	description = <<DESCRIPTION
	Arcanum is a game from 2001 that shipped with alot of bugs. 
	Modders have removed all the originals making this game really fun 
	to play (despite that old look graphics). This is my guide that will
	show you how to play arcanum without spoiling the plot.
	DESCRIPTION
    domain_name = "asdasd.cloudfront.net"
	#domain_name = module.terrahouse_aws.cloudfront_url
	town = "gamers-grotto"
	content_version = 1 
  }
  