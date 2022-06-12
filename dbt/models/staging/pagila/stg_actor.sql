{%- set surrogate_key_columns = ['actor_id', 'first_name', 'last_name'] -%}

WITH actor as (
     SELECT *
       FROM {{ source('src', 'actor') }}
),
final as (
      SELECT actor_id,
             first_name,
             last_name,
             last_update
        FROM actor
),
final_surrogate_key as (
  SELECT {{ dbt_utils.surrogate_key(surrogate_key_columns) }} as actor_key,
         final.*
    FROM final
)
SELECT *
  FROM final_surrogate_key
