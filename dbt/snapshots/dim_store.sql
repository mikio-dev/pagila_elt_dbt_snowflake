{% snapshot dim_store %}

{{
    config(
        unique_key='store_id',
        strategy='check',
        check_cols=['store_key'],
        invalidate_hard_deletes=True,
    )
}}

SELECT *
  FROM {{ ref('stg_store') }}

{% endsnapshot %}