resource "aws_iam_user" "create-user" {
  for_each = {
    for user_groups in local.users_groups :
      "${user_groups.group}.${user_groups.user}" => user_groups
  }

  name = each.value.user
  path = "/${var.users.prefix_name}/${each.value.group}/"

  tags = var.tags
}

resource "aws_iam_user_group_membership" "group-membership" {
  for_each = {
    for user_groups in local.users_groups :
      "${user_groups.group}.${user_groups.user}" => user_groups
  }

  user   = each.value.user
  groups = [
    each.value.group
  ]

  depends_on = [
    aws_iam_user.create-user
  ]
}