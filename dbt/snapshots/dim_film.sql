{% snapshot dim_film %}

{{
    config(
        unique_key='film_id',
        strategy='check',
        check_cols=['film_key'],
        invalidate_hard_deletes=True,
    )
}}

SELECT *
  FROM {{ ref('stg_film') }}

{% endsnapshot %}