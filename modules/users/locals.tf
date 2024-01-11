locals {
  users_groups = flatten([
    for group, users in var.users.groups_users : [
      for user in users : {
        group = group
        user = user
      }
    ]
  ])
}