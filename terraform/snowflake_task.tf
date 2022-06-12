locals {
  tables = toset([
    "ACTOR",
    "ADDRESS",
    "CATEGORY",
    "CITY",
    "COUNTRY",
    "CUSTOMER",
    "FILM_ACTOR",
    "FILM_CATEGORY",
    "FILM",
    "INVENTORY",
    "LANGUAGE",
    "STAFF",
    "STORE"
  ])
}

resource "snowflake_task" "truncate_task" {
  for_each  = local.tables
  provider  = snowflake.account_admin
  database  = snowflake_database.db.name
  schema    = snowflake_schema.schema.name
  warehouse = snowflake_warehouse.warehouse.name
  name      = "TRUNCATE_${each.key}"
  # schedule             = "60 MINUTE"
  schedule             = "5 MINUTE"
  sql_statement        = <<EOT
TRUNCATE TABLE ${snowflake_database.db.name}.${snowflake_schema.schema.name}.${each.key}
EOT
  user_task_timeout_ms = 10000
  enabled              = true
}

resource "snowflake_task" "load_task" {
  for_each             = local.tables
  provider             = snowflake.account_admin
  database             = snowflake_database.db.name
  schema               = snowflake_schema.schema.name
  warehouse            = snowflake_warehouse.warehouse.name
  name                 = "LOAD_${each.key}"
  after                = snowflake_task.truncate_task[each.key].name
  sql_statement        = <<EOT
COPY INTO ${snowflake_database.db.name}.${snowflake_schema.schema.name}.${each.key}
    FROM @${snowflake_database.db.name}.${snowflake_schema.schema.name}.${snowflake_stage.stage.name}
    pattern='pagila/batch/${lower(each.key)}.csv'
EOT
  user_task_timeout_ms = 10000
  enabled              = true
}
