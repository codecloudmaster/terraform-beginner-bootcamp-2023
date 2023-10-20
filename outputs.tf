output "bucket_name" {
    description = "Bucket name for our static website hosting"
    value = module.terrahouse_aws.bucket_name  
}


output "aws_cloudfront_distribution" {
  description = "CDN distribution ID"
  value = module.terrahouse_aws.aws_cloudfront_distribution
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain Name"
  value = module.terrahouse_aws.cloudfront_url
}



