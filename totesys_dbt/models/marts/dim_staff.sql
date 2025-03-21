WITH dim_staff AS (
    SELECT
        staff_id,
        first_name,
        last_name,
        d.department_name as department_name,
        d.location as location,
        email_address
    FROM public.staff s
    LEFT JOIN
        public.department d
    ON 
        d.department_id = s.department_id
)
SELECT * FROM dim_staff