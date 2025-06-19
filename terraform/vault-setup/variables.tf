variable "vault_address" {
  type = string
}

variable "vault_token" {
  type = string
  sensitive = true
}

variable "environment" {
  type = string
  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be development, staging, or production."
  }
}
