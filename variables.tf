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
