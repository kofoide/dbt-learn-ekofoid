SELECT
    ID AS payment_id
,   "orderID" AS order_id
,   "paymentMethod" AS payment_method
,   AMOUNT AS amount
,   CREATED AS created_date
FROM raw.stripe.payment