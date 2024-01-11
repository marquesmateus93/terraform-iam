locals {
  is_read_only = var.role_name == "read_only" ? true : false
}