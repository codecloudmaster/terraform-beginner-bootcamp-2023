output "bucket_name" {
    description = "Bucket name for our static website hosting"
    value = module.terrahouse_aws.bucket_name  
}

output "aws_s3_bucket_website_endpoint" {
    description = "website endpoint"
    value = module.terrahouse_aws.aws_s3_bucket_website_endpoint
}

output "account_id" {
  description = "current_account_id"
  value = module.terrahouse_aws.account_id
}

output "aws_cloudfront_distribution" {
  description = "CDN distribution ID"
  value = module.terrahouse_aws.aws_cloudfront_distribution
}

output "aws_cloudfront_distribution_arn" {
  value = module.terrahouse_aws.aws_cloudfront_distribution_arn
}

#output "bucket_name2" {
#    value = aws_s3_bucket.website_bucket2.bucket
#}