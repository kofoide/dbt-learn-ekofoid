WITH Customers AS (
    SELECT *
    FROM {{ ref('stg_customers') }}
),
Orders AS (
    SELECT *
    FROM {{ ref('orders')}}
),
CustomerOrders AS (
    SELECT
        customer_id,
        SUM(payment_amount) AS lifetime_value,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders
    FROM Orders
    GROUP BY
        customer_id
)
SELECT
    C.customer_id,
    C.first_name,
    C.last_name,
    CO.first_order_date,
    CO.most_recent_order_date,
    CO.lifetime_value,
    coalesce(CO.number_of_orders, 0) as number_of_orders
FROM
            Customers       C
LEFT JOIN   CustomerOrders  CO USING (customer_id)