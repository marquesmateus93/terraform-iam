resource "aws_iam_role" "role" {
  name = var.role_name
  path = var.path
  assume_role_policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "AWS": var.arn_root
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )

  tags = merge({Name = var.role_name},
              var.tags)
}