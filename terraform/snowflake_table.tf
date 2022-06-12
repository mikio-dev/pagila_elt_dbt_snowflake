resource "snowflake_schema" "schema" {
  provider = snowflake.sys_admin
  database = snowflake_database.db.name
  name     = var.snowflake_schema
}

# CREATE TABLE IF NOT EXISTS src.actor (
#     actor_id integer,
#     first_name text,
#     last_name text,
#     last_update timestamp with time zone
# );

resource "snowflake_table" "actor" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "ACTOR"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "ACTOR_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "FIRST_NAME"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "LAST_NAME"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.address (
#     address_id integer,
#     address text,
#     address2 text,
#     district text,
#     city_id integer,
#     postal_code text,
#     phone text,
#     last_update timestamp with time zone
# );

resource "snowflake_table" "address" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "ADDRESS"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "ADDRESS_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "ADDRESS"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "ADDRESS2"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "DISTRICT"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "CITY_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "POSTAL_CODE"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "PHONE"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.category (
#     category_id integer,
#     name text,
#     last_update timestamp with time zone
# );

resource "snowflake_table" "category" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "CATEGORY"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "CATEGORY_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "NAME"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.city (
#     city_id integer,
#     city text,
#     country_id integer,
#     last_update timestamp with time zone
# );

resource "snowflake_table" "city" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "CITY"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "CITY_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "CITY"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "COUNTRY_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.country (
#     country_id integer,
#     country text,
#     last_update timestamp with time zone
# );

resource "snowflake_table" "country" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "COUNTRY"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "COUNTRY_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "COUNTRY"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.customer (
#     customer_id integer,
#     store_id integer,
#     first_name text,
#     last_name text,
#     email text,
#     address_id integer,
#     activebool boolean,
#     create_date date,
#     last_update timestamp with time zone,
#     active integer
# );

resource "snowflake_table" "customer" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "CUSTOMER"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "CUSTOMER_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "STORE_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "FIRST_NAME"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "LAST_NAME"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "EMAIL"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "ADDRESS_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "ACTIVEBOOL"
    type     = "BOOLEAN"
    nullable = true
  }

  column {
    name     = "CREATE_DATE"
    type     = "DATE"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }

  column {
    name     = "ACTIVE"
    type     = "NUMBER(38,0)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.film (
#     film_id integer,
#     title text,
#     description text,
#     release_year integer,
#     language_id integer,
#     original_language_id integer,
#     rental_duration smallint,
#     rental_rate numeric(4,2),
#     length smallint,
#     replacement_cost numeric(5,2),
#     rating varchar(5),
#     last_update timestamp with time zone,
#     special_features text,
#     fulltext text
# );

resource "snowflake_table" "film" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "FILM"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "FILM_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "TITLE"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "DESCRIPTION"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "RELEASE_YEAR"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "LANGUAGE_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "ORIGINAL_LANGUAGE_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "RENTAL_DURATION"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "RENTAL_RATE"
    type     = "NUMBER(4,2)"
    nullable = true
  }

  column {
    name     = "LENGTH"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "REPLACEMENT_COST"
    type     = "NUMBER(5,2)"
    nullable = true
  }

  column {
    name     = "RATING"
    type     = "VARCHAR(5)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }

  column {
    name     = "SPECIAL_FEATURES"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "FULLTEXT"
    type     = "VARCHAR(16777216)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.film_actor (
#     actor_id integer,
#     film_id integer,
#     last_update timestamp with time zone
# );

resource "snowflake_table" "film_actor" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "FILM_ACTOR"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "ACTOR_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "FILM_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.film_category (
#     film_id integer,
#     category_id integer,
#     last_update timestamp with time zone
# );

resource "snowflake_table" "film_category" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "FILM_CATEGORY"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "FILM_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "CATEGORY_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.inventory (
#     inventory_id integer,
#     film_id integer,
#     store_id integer,
#     last_update timestamp with time zone
# );

resource "snowflake_table" "inventory" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "INVENTORY"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "INVENTORY_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "FILM_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "STORE_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.language (
#     language_id integer,
#     name character(20),
#     last_update timestamp with time zone
# );

resource "snowflake_table" "language" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "LANGUAGE"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "LANGUAGE_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "NAME"
    type     = "VARCHAR(20)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.payment (
#     payment_id integer,
#     customer_id integer,
#     staff_id integer,
#     rental_id integer,
#     amount numeric(5,2),
#     payment_date timestamp with time zone
# );

resource "snowflake_table" "payment" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "PAYMENT"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "PAYMENT_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "CUSTOMER_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "STAFF_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "RENTAL_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "AMOUNT"
    type     = "NUMBER(5,2)"
    nullable = true
  }

  column {
    name     = "PAYMENT_DATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.rental (
#     rental_id integer,
#     rental_date timestamp with time zone,
#     inventory_id integer,
#     customer_id integer,
#     return_date timestamp with time zone,
#     staff_id integer,
#     last_update timestamp with time zone
# );

resource "snowflake_table" "rental" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "RENTAL"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "RENTAL_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "RENTAL_DATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }

  column {
    name     = "INVENTORY_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "CUSTOMER_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "RETURN_DATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }

  column {
    name     = "STAFF_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.staff (
#     staff_id integer,
#     first_name text,
#     last_name text,
#     address_id integer,
#     email text,
#     store_id integer,
#     active boolean,
#     username text,
#     password text,
#     last_update timestamp with time zone,
#     picture varchar
# );

resource "snowflake_table" "staff" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "STAFF"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "STAFF_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "FIRST_NAME"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "LAST_NAME"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "ADDRESS_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "EMAIL"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "STORE_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "ACTIVE"
    type     = "BOOLEAN"
    nullable = true
  }

  column {
    name     = "USERNAME"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "PASSWORD"
    type     = "VARCHAR(16777216)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }

  column {
    name     = "PICTURE"
    type     = "VARCHAR(16777216)"
    nullable = true
  }
}

# CREATE TABLE IF NOT EXISTS src.store (
#     store_id integer,
#     manager_staff_id integer,
#     address_id integer,
#     last_update timestamp with time zone
# );

resource "snowflake_table" "store" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.db.name
  schema              = snowflake_schema.schema.name
  name                = "STORE"
  data_retention_days = snowflake_schema.schema.data_retention_days
  change_tracking     = false

  column {
    name     = "STORE_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "MANAGER_STAFF_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "ADDRESS_ID"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "LAST_UPDATE"
    type     = "TIMESTAMP_TZ(9)"
    nullable = true
  }
}
