WITH recursive tmp (t) AS (
    SELECT cast('0001-01-01 00:00:00' as timestamp)
     UNION ALL
    SELECT {{ dbt_utils.dateadd('minute', 1, 't') }}
      FROM tmp 
     WHERE t < cast('0001-01-01 23:59:59' as timestamp)
)
SELECT DISTINCT 
       cast(t as time) as time_value
  FROM tmp
