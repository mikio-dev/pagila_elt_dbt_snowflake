resource "snowflake_warehouse" "warehouse" {
  provider       = snowflake.sys_admin
  name           = var.snowflake_warehouse
  warehouse_size = var.snowflake_wh_size
  auto_suspend   = 60
}

resource "snowflake_database" "db" {
  provider = snowflake.sys_admin
  name     = var.snowflake_database
}

