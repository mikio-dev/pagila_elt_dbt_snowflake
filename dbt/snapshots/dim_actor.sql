{% snapshot dim_actor %}

{{
    config(
        unique_key='actor_id',
        strategy='check',
        check_cols=['actor_key'],
        invalidate_hard_deletes=True,
    )
}}

SELECT *
  FROM {{ ref('stg_actor') }}

{% endsnapshot %}