resource "aws_iam_group" "group-administrators" {
  name = var.group_name
  path = var.path
}