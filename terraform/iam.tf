locals {
  role_arn = "arn:aws:iam::${var.account_id}:role/${var.iam_role_name}"
}

resource "aws_iam_role" "s3_access_role" {
  name               = var.iam_role_name
  assume_role_policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${snowflake_storage_integration.integration.storage_aws_iam_user_arn}"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "${snowflake_storage_integration.integration.storage_aws_external_id}"
                }
            }
        }
    ]
}
EOT
  tags = {
    Name = var.project_name
  }
}

resource "aws_iam_role_policy" "s3_read_access_policy" {
  name   = "s3_policy"
  role   = aws_iam_role.s3_access_role.id
  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3-object-lambda:Get*",
                "s3-object-lambda:List*"
            ],
            "Resource": [
                "${aws_s3_bucket.staging_bucket.arn}",
                "${aws_s3_bucket.staging_bucket.arn}/*"
            ]
        }
    ]
}
EOT
}
