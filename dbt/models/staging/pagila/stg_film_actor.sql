WITH film_actor as (
    SELECT *
      FROM {{ source('src', 'film_actor') }}
),
film as (
    SELECT *
      FROM {{ ref('stg_film') }}
),
actor as (
    SELECT *
      FROM {{ ref('stg_actor') }}
),
joined as (
    SELECT f.film_key,
           a.actor_key,
           fa.film_id,
           fa.actor_id
      FROM film_actor AS fa
      LEFT OUTER JOIN film AS f
        ON fa.film_id = f.film_id
      LEFT OUTER JOIN actor AS a
        ON fa.actor_id = a.actor_id 
),
final as (
  SELECT *
    FROM joined
)
SELECT *
  FROM final