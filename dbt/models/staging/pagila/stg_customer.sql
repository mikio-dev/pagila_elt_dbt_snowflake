{%- set surrogate_key_columns = [
          'first_name',
          'last_name',
          'email',
          'create_date',
          'active',
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

WITH customer as (
     SELECT * 
       FROM {{ source('src', 'customer') }}
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
joined AS (
     SELECT c.customer_id,
            c.first_name,
            c.last_name,
            c.email,
            c.create_date,
            c.active,
            c.address_id,
            a.address,
            a.address2,
            a.district,
            a.city_id,
            ci.city,
            a.postal_code,
            ci.country_id,
            co.country,
            a.phone,
            c.last_update
       FROM customer AS c
       LEFT OUTER JOIN address AS a
         ON c.address_id = a.address_id
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
  SELECT {{ dbt_utils.surrogate_key(surrogate_key_columns) }} as customer_key,
         final.*
    FROM final
)
SELECT *
  FROM final_with_surrogate_key
  
