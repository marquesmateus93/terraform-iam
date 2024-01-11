resource "aws_iam_group_policy" "group-policy-administrators" {
  name  = var.group_name
  group = aws_iam_group.group-administrators.name

  policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "sts:AssumeRole"
          ],
          "Resource": var.arn_roles
        }
      ]
    }
  )
}