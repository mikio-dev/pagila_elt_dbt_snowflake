{%- set surrogate_key_columns = [
          'title',
          'description',
          'release_year',
          'language',
          'original_language',
          'rental_duration',
          'rental_rate',
          'film_length',
          'replacement_cost',
          'rating',
          'special_features',
          'category_action',
          'category_animation',
          'category_children',
          'category_classics',
          'category_comedy',
          'category_documentary',
          'category_drama',
          'category_family',
          'category_foreign',
          'category_games',
          'category_horror',
          'category_music',
          'category_new',
          'category_scifi',
          'category_sports',
          'category_travel'
        ] 
-%}

{%- set categories = {
  1: 'action',
  2: 'animation',
  3: 'children',
  4: 'classics',
  5: 'comedy',
  6: 'documentary',
  7: 'drama',
  8: 'family',
  9: 'foreign',
  10: 'games',
  11: 'horror',
  12: 'music',
  13: 'new',
  14: 'scifi',
  15: 'sports',
  16: 'travel',
}
-%}

WITH film as (
    SELECT *
      FROM {{ source('src', 'film') }}
),
language AS (
    SELECT *
      FROM {{ source('src', 'language') }}
),
film_category AS (
    SELECT *
      FROM {{ source('src', 'film_category') }}
),
category AS (
    SELECT *
      FROM {{ source('src', 'category') }}
),
joined as (
    SELECT DISTINCT
           f.film_id,
           f.title,
           f.description,
           f.release_year,
           l.name as language,
           ol.name as original_language,
           f.rental_duration,
           f.rental_rate,
           f.length as film_length,
           f.replacement_cost,
           f.rating,
           f.special_features,
           {%- for category_id in categories %}
           {{ check_category('c.category_id', category_id) }} category_{{ categories[category_id] }},
           {%- endfor %}
           f.last_update
       FROM film AS f 
       LEFT OUTER JOIN language AS l 
         ON f.language_id = l.language_id 
       LEFT OUTER JOIN language AS ol 
         ON f.original_language_id = ol.language_id
       LEFT OUTER JOIN film_category AS fc 
         ON f.film_id = fc.film_id 
       LEFT OUTER JOIN category AS c
         ON fc.category_id = c.category_id 
      GROUP BY f.film_id,
            f.title,
            f.description,
            f.release_year,
            l.name,
            ol.name,
            f.rental_duration,
            f.rental_rate,
            f.length,
            f.replacement_cost,
            f.rating,
            f.special_features,
            f.last_update
),
final as (
  SELECT *
    FROM joined
),
final_with_surrogate_key as (
  SELECT {{ dbt_utils.surrogate_key(surrogate_key_columns) }} as film_key,
         final.*
    FROM final
)
SELECT *
  FROM final_with_surrogate_key