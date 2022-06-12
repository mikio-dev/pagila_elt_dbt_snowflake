provider "snowflake" {
  account  = var.snowflake_account
  region   = var.snowflake_region
  password = var.snowflake_password
  username = var.snowflake_account_user
  alias    = "sys_admin"
  role     = "SYSADMIN"
}

provider "snowflake" {
  account  = var.snowflake_account
  region   = var.snowflake_region
  password = var.snowflake_password
  username = var.snowflake_account_user
  alias    = "account_admin"
  role     = "ACCOUNTADMIN"
}
