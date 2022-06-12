{% snapshot dim_staff %}

{{
    config(
        unique_key='staff_id',
        strategy='check',
        check_cols=['staff_key'],
        invalidate_hard_deletes=True,
    )
}}

SELECT *
  FROM {{ ref('stg_staff') }}

{% endsnapshot %}