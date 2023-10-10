output "bucket_name" {
    value = aws_s3_bucket.website_bucket.bucket
    
}

#output "aws_s3_bucket_website_endpoint" {
#  value = aws_s3_bucket_website_configuration.conf.website_endpoint
#}
#

output "aws_cloudfront_distribution" {
  value = aws_cloudfront_distribution.s3_distribution.id
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

#output "aws_cloudfront_distribution_arn" {
#  value = aws_cloudfront_distribution.s3_distribution.arn
#}
