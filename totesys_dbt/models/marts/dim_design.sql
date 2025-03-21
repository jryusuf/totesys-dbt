WITH dim_design as (
    SELECT 
        design_id,
        design_name,
        file_location,
        file_name
    FROM public.stg_design
)
SELECT * FROM dim_design