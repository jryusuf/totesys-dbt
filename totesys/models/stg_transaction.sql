WITH raw_transaction AS(
    SELECT *
    FROM public.transaction
)
SELECT * FROM raw_transaction