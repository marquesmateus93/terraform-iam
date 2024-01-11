variable "path" {
  description = ""
  type        = string
}

variable "role_name" {
  description = "Roles groups name."
  type        = string
  validation {
    condition = can(
      regex(
        "(administrator|developer|read_only)",
        var.role_name
      )
    )
    error_message = "Role name not allowed. Must to be: 'administrator' or  'developer' or 'read_only'."
  }
}

variable "arn_root" {
  description = "Root accounts destination allowance."
  type        = list(string)
  validation {
    condition = alltrue([
      for arn in var.arn_root : can(
        regex(
          "(arn:aws:iam::)([0-9]{12})(:root)",
          arn))
    ])
    error_message = "ARN root format not allowed."
  }
}

variable "tags" {
  description = "Tracking tags."
  type        = map(string)
  validation {
    condition = alltrue ([
      for tag in keys(var.tags) : contains(["environment", "creator_id", "powered_by"],
        tag)
    ])
    error_message = "Tags must contain at least: 'environment', 'creator_id' and 'powered_by'."
  }
}