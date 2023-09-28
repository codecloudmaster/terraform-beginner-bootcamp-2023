
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket



resource "aws_s3_bucket" "website_bucket" {
  bucket = var.s3_bucket_name
  
  tags = {
    UserUuid = var.user_uuid
 }
}

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
