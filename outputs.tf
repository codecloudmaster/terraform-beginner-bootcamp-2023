output "bucket_name" {
    description = "Bucket name for our static website hosting"
    value = module.terrahouse_aws.bucket_name  
}

#output "aws_s3_bucket_website_endpoint" {
#    description = "website endpoint"
#    value = module.terrahouse_aws.aws_s3_bucket_website_endpoint
#}


output "aws_cloudfront_distribution" {
  description = "CDN distribution ID"
  value = module.terrahouse_aws.aws_cloudfront_distribution
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain Name"
  value = module.terrahouse_aws.cloudfront_url
}

#output "aws_cloudfront_distribution_arn" {
#  value = module.terrahouse_aws.aws_cloudfront_distribution_arn
#}

