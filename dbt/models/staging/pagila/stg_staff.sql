{%- set surrogate_key_columns = [
      'first_name',
      'last_name',
      'address_id',
      'email',
      'store_id',
      'active',
      'username',
      'password'
    ]
-%}

WITH staff as (
    SELECT *
      FROM {{ source('src', 'staff') }}
),
final as (
  SELECT staff_id,
        first_name,
        last_name,
        address_id,
        email,
        store_id,
        active,
        username,
        password,
        last_update
    FROM staff
),
final_surrogate_key as (
  SELECT {{ dbt_utils.surrogate_key(surrogate_key_columns) }} as staff_key,
         final.*
    FROM final
)
SELECT *
  FROM final_surrogate_key