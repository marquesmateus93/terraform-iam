resource "aws_iam_policy" "non-read-only-policy" {
  count = local.is_read_only ? 0 : 1

  name    = var.role_name
  path    = var.path
  policy  = var.role_name == "administrators" ? file("${path.module}/files/policies/administrators.json") : file("${path.module}/files/policies/developers.json")

  tags = merge({Name = var.role_name},
              var.tags)

  depends_on = [
    aws_iam_role.role
  ]
}

resource "aws_iam_policy_attachment" "non-read-only-policy-attachment" {
  count = local.is_read_only ? 0 : 1

  name       = var.role_name
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.non-read-only-policy[0].arn

  depends_on = [
    aws_iam_role.role,
    aws_iam_policy.non-read-only-policy
  ]
}

resource "aws_iam_policy_attachment" "read-only-policy-attachment" {
  count = local.is_read_only ? 1 : 0

  name       = var.role_name
  roles      = [aws_iam_role.role.name]
  policy_arn = data.aws_iam_policy.read_only.arn

  depends_on = [
    aws_iam_role.role
  ]
}