WITH raw_payment_type AS(
    SELECT *
    FROM public.payment_type
)
SELECT * FROM raw_payment_type