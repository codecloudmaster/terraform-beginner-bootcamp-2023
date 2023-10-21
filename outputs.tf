output "bucket_name" {
    description = "Bucket name for our static website hosting"
    value = {for k in keys(local.homes_path_aws) : k => module.terrahome_aws[k].bucket_name}  
}


output "aws_cloudfront_distribution" {
  description = "CDN distribution ID"
  value = {for k in keys(local.homes_path_aws) : k => module.terrahome_aws[k].aws_cloudfront_distribution}
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain Name"
  value = {for k in keys(local.homes_path_aws) : k => module.terrahome_aws[k].cloudfront_url}
}



