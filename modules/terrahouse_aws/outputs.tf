output "bucket_name" {
    value = aws_s3_bucket.website_bucket.bucket
    
}

output "aws_s3_bucket_website_endpoint" {
  value = aws_s3_bucket_website_configuration.conf.website_endpoint

}