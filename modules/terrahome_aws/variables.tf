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