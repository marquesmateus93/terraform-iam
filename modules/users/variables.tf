variable "users" {
  description = <<EOF

  EOF
  type = object({
    groups_users  = map(list(string))
    prefix_name   = string
  })

  validation {
    condition     = var.users.groups_users != null
    error_message = "Statement cannot be empty!"
  }

  validation {
    condition = can(
      regex(
        "[a-z-]",
        var.users.prefix_name
      )
    )
    error_message = "Just uppercase and hifen are allowed."
  }
}

variable "tags" {
  description = "Tracking tags."
  type        = map(string)
  validation {
    condition = alltrue([
      for tag in keys(var.tags) : contains(["prefix_name", "environment", "creator_id"],
        tag)
    ])
    error_message = "Tags must contain at least: 'environment', 'creator_id' and 'powered_by'."
  }
}