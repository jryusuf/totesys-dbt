WITH fact_sales_order AS(
    SELECT
        sales_order_id,
        created_at :: DATE,
        created_at :: TIME as created_time,
        last_updated:: DATE,
        last_updated :: TIME as last_updated_time,
        staff_id as sales_staff_id,
        counterparty_id,
        units_sold,
        unit_price,
        currency_id,
        design_id,
        agreed_payment_date :: DATE,
        agreed_delivery_date :: DATE,
        agreed_delivery_location_id
    FROM stg_sales_order
)
SELECT * FROM fact_sales_order