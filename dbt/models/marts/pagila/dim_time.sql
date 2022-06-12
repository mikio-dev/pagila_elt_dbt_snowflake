with times (t) as (
    SELECT time_value
      FROM {{ ref('stg_time') }}
),
enriched_times as (
    SELECT md5(to_char(t, 'HH24MI')) as time_key,
           t as time_value,
           cast(to_char(t, 'HH24') as smallint) as hours24,
           cast(to_char(t, 'HH12') as smallint) as hours12,
           cast(to_char(t, 'MI') as smallint) as minutes,
           to_char(t, 'AM') as am_pm
      FROM times
)
SELECT *
  FROM enriched_times

