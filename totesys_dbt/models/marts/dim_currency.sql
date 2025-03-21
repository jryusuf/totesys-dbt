WITH dim_currency AS (
    SELECT
        currency_id,
        currency_code,
        CASE
            WHEN currency_code = 'GBP' THEN 'Sterling'
            WHEN currency_code = 'EUR' THEN 'Euro'
            WHEN currency_code = 'USD' THEN 'Dollar'
        END as currency_name
    FROM public.stg_currency
)
SELECT * FROM dim_currency