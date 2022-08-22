// Export in your shell as TF_VAR_token
variable "token" {
  type        = string
  description = "TF Cloud user token"
  sensitive = true
}

// Export in your shell as TF_VAR_org_owner
variable "org_owner" {
  type        = string
  description = "Email of the org owner"
  sensitive = true
}

// Export in your shell as TF_VAR_gh_token1
variable "gh_token1" {
  type        = string
  description = "github acc"
  sensitive = true
}
