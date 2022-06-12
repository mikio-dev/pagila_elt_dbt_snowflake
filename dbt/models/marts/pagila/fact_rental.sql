{{
    config(
        materialized='incremental',
        unique_key='rental_id'
    )
}}

{% if is_incremental() %}
WITH filter as (
  SELECT max(rental_date) AS max_date
    FROM {{ this }} AS r
)
{% endif %}
SELECT r.*
  FROM {{ ref('stg_rental') }} AS r
{% if is_incremental() %}
  , filter
 WHERE r.rental_date > filter.max_date
{% endif %}
