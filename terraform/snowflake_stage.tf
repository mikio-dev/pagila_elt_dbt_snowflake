resource "snowflake_storage_integration" "integration" {
  provider                  = snowflake.account_admin
  name                      = "S3_INTEGRATION"
  type                      = "EXTERNAL_STAGE"
  enabled                   = true
  storage_provider          = "S3"
  storage_allowed_locations = ["s3://${aws_s3_bucket.staging_bucket.bucket}/"]
  storage_aws_role_arn      = local.role_arn
}

resource "snowflake_file_format" "csv_file_format" {
  provider                     = snowflake.account_admin
  name                         = "S3_CSV_FILE_FORMAT"
  database                     = snowflake_database.db.name
  schema                       = snowflake_schema.schema.name
  format_type                  = "CSV"
  empty_field_as_null          = true
  skip_header                  = 1
  compression                  = "NONE"
  field_delimiter              = ","
  record_delimiter             = "\n"
  binary_format                = "HEX"
  escape                       = "NONE"
  escape_unenclosed_field      = "NONE"
  field_optionally_enclosed_by = "\""
  encoding                     = "UTF8"
  date_format                  = "AUTO"
  time_format                  = "AUTO"
  timestamp_format             = "AUTO"

}

resource "snowflake_stage" "stage" {
  provider            = snowflake.account_admin
  name                = var.snowflake_stage
  url                 = "s3://${aws_s3_bucket.staging_bucket.bucket}/"
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  storage_integration = snowflake_storage_integration.integration.name
  file_format         = <<EOT
FORMAT_NAME = ${snowflake_database.db.name}.${snowflake_schema.schema.name}.${snowflake_file_format.csv_file_format.name}
EOT
}
