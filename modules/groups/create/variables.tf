#variable "prefix_name" {
#  description = "Resources prefix name."
#  type        = string
#  validation {
#    condition = can(
#      regex(
#        "[a-z-]",
#        var.prefix_name
#      )
#    )
#    error_message = "Just uppercase and hifen are allowed."
#  }
#}

variable "group_name" {
  description = "Users group name."
  type        = string
  validation {
    condition = can(
      regex(
        "(administrators|developers|read_only)",
        var.group_name
      )
    )
    error_message = "Group name not allowed. Must to be: 'administrators' or  'developers' or 'read_only'."
  }
}

variable "path" {
  description = ""
  type        = string
}

variable "arn_roles" {
  description = "Accounts administrators roles ARNs."
  type        = list(string)
  validation {
    condition = alltrue([
      for role in var.arn_roles : can(regex("(arn:aws:iam::)([0-9]{12})(:role/)([a-z]*/)(all/)(administrators|developers|read_only)", role))
    ])
    error_message = "ARN role format not allowed."
  }
}

#variable "tags" {
#  description = "Tracking tags."
#  type        = map(string)
#  validation {
#    condition = alltrue ([
#      for tag in keys(var.tags) : contains(["environment", "creator_id", "powered_by"],
#        tag)
#    ])
#    error_message = "Tags must contain at least: 'environment', 'creator_id' and 'powered_by'."
#  }
#}