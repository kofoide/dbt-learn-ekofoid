WITH Payments AS (
    SELECT *
    FROM {{ ref('stg_payments')}}
),
Orders AS (
    SELECT *
    FROM {{ ref('stg_orders')}}
)

SELECT
    O.order_id
,   O.customer_id
,   O.order_date
,   SUM(P.amount) AS payment_amount
FROM
            Orders      O
LEFT JOIN   Payments    P USING (order_id)
GROUP BY
    O.order_id
,   O.customer_id
,   O.order_date