output "bucket_name" {
    description = "Bucket name for our static website hosting"
    value = module.terrahouse_aws.bucket_name  
}

#output "bucket_name2" {
#    value = aws_s3_bucket.website_bucket2.bucket
#}