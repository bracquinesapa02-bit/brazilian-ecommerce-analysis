--1. Shipping Delays
--Answer the question: "Which orders were delivered later than the estimated delivery date?"

SELECT
    orders.order_id,
    orders.order_purchase_timestamp,
    orders.order_delivered_customer_date,
    orders.order_estimated_delivery_date,
    orders.order_delivered_customer_date - orders.order_estimated_delivery_date AS delay_duration
FROM
    orders
WHERE
    orders.order_status = 'delivered' AND orders.order_delivered_customer_date 
    > orders.order_estimated_delivery_date
ORDER BY delay_duration DESC;

/*
Insight:
-Several orders experienced extremely long shipping delays compared to their estimated
delivery dates.
-Some delayed orders arrived more than 100 to 180 days late,
indicating major delivery inefficiencies or operational issues.
-Large delivery delays may negatively impact customer satisfaction and customer retention.
-The results suggest that delivery performance was inconsistent across certain orders.
*/

--2. Fastest Sellers
--Answer the question:"Which sellers deliver products the fastest?"

SELECT
    order_items.seller_id,
    ROUND(AVG(EXTRACT(DAY FROM(orders.order_delivered_customer_date - orders.order_purchase_timestamp))), 2)
    AS average_delivery_days
FROM
    order_items
JOIN orders ON order_items.order_id = orders.order_id
WHERE 
    orders.order_status = 'delivered'
GROUP BY
    order_items.seller_id
ORDER BY 
    average_delivery_days ASC;

/*
Insight:
-Some sellers delivered orders very quickly, with average delivery times between 1 to 2 days.
-These fastest sellers may have strong fulfillment, better logistics, or customers located near them.
-Fast delivery performance can improve customer satisfaction and support stronger repeat purchasing behavior.
*/

--3. Delivery Performance by Region
--Answer the question: "Which customer regions have faster or slower delivery performance?"

SELECT
    customers.customer_state,
    COUNT(orders.order_id) AS total_delivered_orders,
    ROUND(AVG(EXTRACT(DAY FROM(orders.order_delivered_customer_date - orders.order_purchase_timestamp))), 2) 
    AS average_delivery_days
FROM
    customers
JOIN orders ON customers.customer_id = orders.customer_id
WHERE
    orders.order_status = 'delivered'
GROUP BY
    customers.customer_state
ORDER BY
    average_delivery_days DESC;

/*
Insight:
-Delivery performance varied significantly across customer regions.
-RR, AP, and AM recorded the slowest average delivery times,
with deliveries taking more than 25 days on average.
-SP achieved the fastest delivery performance with an average delivery time
of approximately 8 days.
-Regions with larger customer concentrations, such as SP, MG, and PR,
generally experienced faster deliveries, possibly due to stronger logistics infrastructure.
-The results suggest that geographic location has a major impact on delivery efficiency.
*/
