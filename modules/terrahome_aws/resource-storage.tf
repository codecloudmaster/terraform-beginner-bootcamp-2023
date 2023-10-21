
resource "aws_s3_bucket" "website_bucket" {
  #bucket = var.s3_bucket_name
  
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


resource "terraform_data" "content_version" {
  input = var.content_version
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${var.public_path}/index.html"
  content_type = "text/html"
  etag = filemd5("${var.public_path}/index.html")
  
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
  
}

resource "aws_s3_object" "upload_assets" {
  for_each = fileset("${var.public_path}/assets/", "*.{jpg,png,gif}")
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "assets/${each.key}"
  source = "${var.public_path}/assets/${each.key}"
  
  etag = filemd5("${var.public_path}/assets/${each.key}")
  
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = "${var.public_path}/error.html"
  content_type = "text/html"
  etag = filemd5("${var.public_path}/error.html")
}
