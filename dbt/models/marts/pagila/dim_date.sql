with dates as (
    SELECT cast(date_day as date) as d
      FROM {{ ref('stg_date') }}
),
enriched_dates as (
    SELECT md5(to_char(d, 'YYYYMMDD')) as date_key,
           cast(to_char(d, 'YYYY-MM-DD') as date) as date_value,
           to_char(d, 'DD MMMM YYYY') as date_full,
           to_char(d, 'YYYY') as year_number,
           quarter(d) as quarter,
           'Q' || quarter(d) as quarter_name,
           to_char(d, 'YYYY') || '-Q' || quarter(d) as year_quarter,
           to_char(d, 'YYYY') || '-' || to_char(d, 'MM') as year_month,
           cast(to_char(d, 'MM') as smallint) as month_number,
           to_char(d, 'MMMM') as month_name,
           day(d) as day_number,
           dayofyear(d) as day_in_year,
           week(d) as week_in_year,
           dayofweek(d) as day_of_week
      FROM dates
)
SELECT *
  FROM enriched_dates
