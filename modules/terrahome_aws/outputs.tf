output "bucket_name" {
    value = aws_s3_bucket.website_bucket.bucket
    
}

output "aws_cloudfront_distribution" {
  value = aws_cloudfront_distribution.s3_distribution.id
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}


