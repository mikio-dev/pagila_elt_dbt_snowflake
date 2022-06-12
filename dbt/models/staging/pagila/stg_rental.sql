WITH rental as (
    SELECT *
      FROM {{ source('src', 'rental') }}
),
inventory as (
    SELECT *
      FROM {{ source('src', 'inventory') }}
),
store as (
    SELECT *
      FROM {{ ref('stg_store') }}
),
customer as (
    SELECT *
      FROM {{ ref('stg_customer') }}
),
film as (
    SELECT *
      FROM {{ ref('stg_film') }}
),
staff as (
    SELECT *
      FROM {{ ref('stg_staff') }}
),
joined as (
    SELECT r.rental_id,
           md5(to_char(cast(r.rental_date as date), 'YYYYMMDD')) as rental_date_key,
           r.rental_date,
           sto.store_key,
           c.customer_key,
           f.film_key,
           sta.staff_key,
           md5(to_char(cast(r.return_date as date), 'YYYYMMDD')) as return_date_key,
           md5(to_char(cast(r.return_date as time), 'HH24MI')) as return_time_key,
           1 as rental_count,
           CASE WHEN return_date IS NULL THEN 0 ELSE 1 END as return_count,
           r.last_update
      FROM rental r
      LEFT OUTER JOIN inventory i 
        ON r.inventory_id = i.inventory_id 
      LEFT OUTER JOIN store sto
        ON i.store_id = sto.store_id
      LEFT OUTER JOIN customer c 
        ON r.customer_id = c.customer_id 
      LEFT OUTER JOIN film f 
        ON i.film_id = f.film_id
      LEFT OUTER JOIN staff sta 
        ON r.staff_id = sta.staff_id
),
final as (
    SELECT *
      FROM joined
)
SELECT *
  FROM final
