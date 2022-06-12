{% snapshot dim_film_actor %}

{{
    config(
        unique_key="cast(film_id as text) || '%' || cast(actor_id as text)",
        strategy='check',
        check_cols=['film_key', 'actor_key'],
        invalidate_hard_deletes=True,
    )
}}

SELECT *
  FROM {{ ref('stg_film_actor') }}

{% endsnapshot %}