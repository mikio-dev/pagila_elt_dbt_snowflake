variable "account_id" {
  description = "Account ID"
  type        = string
  sensitive   = true
}

variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "s3_staging_bucket_name" {
  description = "S3 bucket name for the staging area"
  type        = string
}

variable "iam_role_name" {
  description = "IAM role name for the source data loading from S3 to Snowflake"
  type        = string
}

variable "snowflake_account" {
  description = "The name of the Snowflake account"
  type        = string
}

variable "snowflake_region" {
  description = "Snowflake region"
  type        = string
}

variable "snowflake_account_user" {
  description = "Snowflake account user"
  type        = string
}

variable "snowflake_password" {
  description = "Snowflake account password"
  type        = string
  sensitive   = true
}

variable "snowflake_database" {
  description = "The name of the Snowflake database"
  type        = string
}

variable "snowflake_warehouse" {
  description = "The name of the Snowflake warehouse"
  type        = string
}

variable "snowflake_wh_size" {
  description = "The size of the Snowflake warehouse"
  type        = string
  default     = "x-small"
}

variable "snowflake_schema" {
  description = "The name of the Snowflake schema"
  type        = string
}

variable "snowflake_stage" {
  description = "The name of the Snowflake stage"
  type        = string
}
