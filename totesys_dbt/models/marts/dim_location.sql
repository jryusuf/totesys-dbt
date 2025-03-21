WITH dim_location as (
    SELECT 
        address_id as location_id,
        address_line_1,
        address_line_2,
        district,
        city,
        postal_code,
        country,
        phone
    FROM public.stg_address
)
SELECT * FROM dim_location