{% macro check_category(col_name, category_id) -%}
cast(cast(sum(case when {{ col_name }} = {{ category_id }} then 1 else 0 end) as integer) as boolean)
{%- endmacro %}