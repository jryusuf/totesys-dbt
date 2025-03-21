WITH raw_generate_date AS (
    {{ dbt_date.get_date_dimension("2020-01-01", "2030-01-01") }}
),
dim_date AS(
    SELECT
        date_day as date_id,
        year_number as year,
        month_of_year as month,
        month_name,
        day_of_week_name as day_name,
        day_of_month :: INTEGER as day,
        quarter_of_year as quarter,
        day_of_week
    FROM raw_generate_date
)
SELECT * FROM dim_date