
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.s3_bucket_name
  
  tags = {
    UserUuid = var.user_uuid
 }
}

resource "aws_s3_bucket_policy" "allow_access_from_cloudfront" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_cloudfront.json
}


data "aws_iam_policy_document" "allow_access_from_cloudfront" {
  statement {
    sid = "AllowCloudFrontServicePrincipal"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website_bucket.arn}/*"]
    effect = "Allow"
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values = ["${aws_cloudfront_distribution.s3_distribution.arn}"]
    }
  }

}

# With CDN we do not needed website settings.

#resource "aws_s3_bucket_website_configuration" "conf" {
#  bucket = aws_s3_bucket.website_bucket.bucket
#
#  index_document {
#    suffix = "index.html"
#  }
#
#  error_document {
#    key = "error.html"
#  }
#}
resource "terraform_data" "content_version" {
  input = var.content_version
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = var.index_html_filepath
  content_type = "text/html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.index_html_filepath)
  
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
  
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = var.error_html_filepath
  content_type = "text/html"
  etag = filemd5(var.error_html_filepath)
}













