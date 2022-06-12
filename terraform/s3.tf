resource "aws_s3_bucket" "staging_bucket" {
  bucket = var.s3_staging_bucket_name
  tags = {
    Name = var.project_name
  }
}

resource "aws_s3_bucket_public_access_block" "staging_bucket" {
  bucket                  = aws_s3_bucket.staging_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "staging_bucket" {
  bucket = aws_s3_bucket.staging_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "staging_bucket" {
  bucket = aws_s3_bucket.staging_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket      = aws_s3_bucket.staging_bucket.id
  eventbridge = true
  queue {
    queue_arn     = snowflake_pipe.pipe["RENTAL"].notification_channel
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = "csv"
  }
}
