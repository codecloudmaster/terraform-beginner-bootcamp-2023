variable "user_uuid" {
  type        = string
  description = "Unique identifier for the user"
  
  validation {
    condition     = length(var.user_uuid) > 0
    error_message = "User UUID cannot be an empty string"
  }
  
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "Invalid User UUID format. It should be in UUID format (e.g., xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)"
  }
}
#
#variable "s3_bucket_name" {
#  type        = string
#  description = "Name of the S3 bucket"
#
#  validation {
#    condition     = length(var.s3_bucket_name) > 2 && length(var.s3_bucket_name) < 64
#    error_message = "S3 bucket name must be between 3 and 63 characters."
#  }
#
#  validation {
#    condition     = can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.s3_bucket_name))
#    error_message = "S3 bucket name must follow AWS S3 naming conventions."
#  }
#}

#variable "index_html_filepath" {
#  description = "The file path for index.html"
#  type        = string
#
#  validation {
#    condition     = fileexists(var.index_html_filepath)
#    error_message = "The provided path for index.html does not exist."
#  }
#}

#variable "error_html_filepath" {
#  description = "The file path for error.html"
#  type        = string
#
#  validation {
#    condition     = fileexists(var.error_html_filepath)
#    error_message = "The provided path for error.html does not exist."
#  }
#}

variable "content_version" {
  description = "The content version. Should be a positive integer starting at 1."
  type = number

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer starting at 1."
  }
}

variable "public_path" {
  description = "Path to assets folder"
  type = string
}