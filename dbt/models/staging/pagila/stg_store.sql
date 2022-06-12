{%- set surrogate_key_columns = [
    'manager_staff_id',
    'manager_first_name',
    'manager_last_name',
    'address_id',
    'address',
    'address2',
    'district',
    'city_id',
    'city',
    'postal_code',
    'country_id',
    'country',
    'phone' 
  ]
-%}

WITH store as (
    SELECT *
      FROM {{ source('src', 'store') }}
),
staff as (
    SELECT *
      FROM {{ source('src', 'staff') }}
),
address as (
    SELECT *
      FROM {{ source('src', 'address') }}
),
city as (
    SELECT *
      FROM {{ source('src', 'city') }}
),
country as (
    SELECT *
      FROM {{ source('src', 'country') }}
),
joined as (
    SELECT sto.store_id,
           sto.manager_staff_id,
           sta.first_name AS manager_first_name,
           sta.last_name AS manager_last_name,
           sto.address_id,
           a.address,
           a.address2,
           a.district,
           a.city_id,
           ci.city, 
           a.postal_code,
           ci.country_id,
           co.country,
           a.phone,
           sto.last_update
      FROM store AS sto 
      LEFT OUTER JOIN staff AS sta
        ON sto.manager_staff_id = sta.staff_id 
      LEFT OUTER JOIN address AS a 
        ON sto.address_id = a.address_id
      LEFT OUTER JOIN city AS ci
        ON a.city_id = ci.city_id
      LEFT OUTER JOIN country AS co 
        ON ci.country_id = co.country_id
),
final as (
  SELECT *
    FROM joined
),
final_with_surrogate_key as (
  SELECT {{ dbt_utils.surrogate_key(surrogate_key_columns) }} as store_key,
         final.*
    FROM final
)
SELECT *
  FROM final_with_surrogate_key
  
