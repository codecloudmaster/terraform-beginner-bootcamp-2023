
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.s3_bucket_name
  
  tags = {
    UserUuid = var.user_uuid
 }
}
