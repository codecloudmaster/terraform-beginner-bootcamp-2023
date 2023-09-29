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

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket"

  validation {
    condition     = length(var.s3_bucket_name) > 2 && length(var.s3_bucket_name) < 64
    error_message = "S3 bucket name must be between 3 and 63 characters."
  }

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.s3_bucket_name))
    error_message = "S3 bucket name must follow AWS S3 naming conventions."
  }
}