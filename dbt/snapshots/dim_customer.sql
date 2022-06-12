{% snapshot dim_customer %}

{{
    config(
        unique_key='customer_id',
        strategy='check',
        check_cols=['customer_key'],
        invalidate_hard_deletes=True,
    )
}}

SELECT *
  FROM {{ ref('stg_customer') }}

{% endsnapshot %}