resource "snowflake_pipe" "pipe" {
  for_each       = toset(["RENTAL", "PAYMENT"])
  provider       = snowflake.account_admin
  database       = snowflake_database.db.name
  schema         = snowflake_schema.schema.name
  name           = "LOAD_${each.key}"
  copy_statement = <<EOT
COPY INTO ${snowflake_database.db.name}.${snowflake_schema.schema.name}.${each.key}
  FROM @${snowflake_database.db.name}.${snowflake_schema.schema.name}.${snowflake_stage.stage.name}
  pattern='pagila/events/${lower(each.key)}.*.csv'
EOT
  auto_ingest    = true
}
