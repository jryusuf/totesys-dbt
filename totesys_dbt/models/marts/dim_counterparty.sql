WITH dim_counterparty AS(
    SELECT
        cp.counterparty_id as counterparty_id,
        cp.counterparty_legal_name as counterparty_legal_name,
        sa.address_line_1 as counterparty_legal_address_line_1,
        sa.address_line_2 as counterparty_legal_address_line_2,
        sa.district as counterparty_legal_district,
        sa.city as counterparty_legal_city, 
        sa.postal_code as counterparty_legal_postal_code,
        sa.country as counterparty_legal_country, 
        sa.phone as counterparty_legal_phone_number
    FROM stg_counterparty as cp
    LEFT JOIN 
        stg_address as sa
    ON 
        cp.legal_address_id = sa.address_id
)
SELECT * FROM dim_counterparty 
