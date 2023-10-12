
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
#resource "aws_s3_bucket" "website_bucket2" {
#  bucket = "anatolii-3ead0a3f-0c08-4426-a3a9-113ac165b414"
#  
#  tags = {
#    UserUuid = var.user_uuid
# }
#}
#
#import {
#  to = aws_s3_bucket.website_bucket2
#  id = "anatolii-3ead0a3f-0c08-4426-a3a9-113ac165b414"
#}
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
