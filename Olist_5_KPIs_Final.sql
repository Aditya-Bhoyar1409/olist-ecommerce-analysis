
-- ==========================================
-- OLIST STORE ANALYSIS
-- FINAL 5 OFFICIAL BUSINESS KPI QUERIES
-- ==========================================


-- KPI 1: Weekday vs Weekend Payment Statistics

SELECT
    CASE
        WHEN DAYOFWEEK(o.order_purchase_timestamp) IN (1, 7)
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,

    p.payment_type,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value), 2) AS total_payment,
    ROUND(AVG(p.payment_value), 2) AS average_payment

FROM olist_orders_dataset o

JOIN olist_order_payments_dataset p
    ON o.order_id = p.order_id

GROUP BY day_type, p.payment_type
ORDER BY day_type, total_payment DESC;


-- KPI 2: Orders with Review Score 5
-- and Payment Type as Credit Card

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT r.review_id) AS total_reviews

FROM olist_orders_dataset o

JOIN olist_order_reviews_dataset r
    ON o.order_id = r.order_id

JOIN olist_order_payments_dataset p
    ON o.order_id = p.order_id

WHERE r.review_score = 5
AND p.payment_type = 'credit_card';


-- KPI 3: Average Delivery Days for Pet Shop

SELECT
    p.product_category_name,
    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(
        AVG(
            TIMESTAMPDIFF(
                SECOND,
                o.order_purchase_timestamp,
                o.order_delivered_customer_date
            ) / 86400.0
        ), 2
    ) AS average_delivery_days

FROM olist_orders_dataset o

JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id

JOIN olist_products_dataset p
    ON oi.product_id = p.product_id

WHERE p.product_category_name = 'pet_shop'
AND o.order_delivered_customer_date IS NOT NULL

GROUP BY p.product_category_name;


-- KPI 4: Average Price and Payment Values
-- for Customers from Sao Paulo

WITH order_prices AS (
    SELECT
        order_id,
        AVG(price) AS average_product_price
    FROM olist_order_items_dataset
    GROUP BY order_id
),

order_payments AS (
    SELECT
        order_id,
        SUM(payment_value) AS total_payment_value
    FROM olist_order_payments_dataset
    GROUP BY order_id
)

SELECT
    c.customer_city,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(AVG(op.average_product_price), 2)
        AS average_price,

    ROUND(AVG(pay.total_payment_value), 2)
        AS average_payment_value

FROM olist_orders_dataset o

JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id

JOIN order_prices op
    ON o.order_id = op.order_id

JOIN order_payments pay
    ON o.order_id = pay.order_id

WHERE LOWER(c.customer_city) = 'sao paulo'

GROUP BY c.customer_city;


-- KPI 5: Relationship Between Shipping Days
-- and Review Scores

SELECT
    r.review_score,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ), 2
    ) AS average_shipping_days

FROM olist_orders_dataset o

JOIN olist_order_reviews_dataset r
    ON o.order_id = r.order_id

WHERE o.order_delivered_customer_date IS NOT NULL

GROUP BY r.review_score

ORDER BY r.review_score DESC;
