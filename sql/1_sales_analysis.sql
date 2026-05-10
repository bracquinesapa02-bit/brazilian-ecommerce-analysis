-- SALES ANALYSIS
-- Project 1: Brazilian E-Commerce Public Dataset by Olist

-- 1. Monthly Revenue Trends
--Question:“How is the company’s revenue changing over time?”

SELECT
    DATE_TRUNC('month', orders.order_purchase_timestamp) AS month,
    ROUND(SUM(order_items.price + order_items.freight_value), 2) AS total_revenue
FROM
    orders
JOIN order_items ON orders.order_id = order_items.order_id
WHERE orders.order_status = 'delivered'
GROUP BY month
ORDER BY month;

/*
Insight:
 Monthly revenue generally increased over time,indicating overall business growth.
 Revenue experienced fluctuations across some months,showing changing customer purchasing activity.
 The business reached its highest revenue levels during the later months of the dataset.
*/

--2. Best-Selling Categories
--Answer the question: “Which product categories sell the most? and “Which categories generate the highest revenue?”

SELECT
    category_translation.product_category_name_english AS product_category,
    COUNT(order_items.product_id) AS total_product_sold,
    ROUND(SUM(order_items.price), 2) AS total_revenue
FROM
    order_items
JOIN products ON order_items.product_id = products.product_id
LEFT JOIN category_translation ON products.product_category_name = category_translation.product_category_name
JOIN orders ON order_items.order_id = orders.order_id
WHERE orders.order_status = 'delivered'
GROUP BY category_translation.product_category_name_english
ORDER BY total_product_sold DESC;

/*
Insight:
 Health beauty, bed bath table, and sports leisure were among the top-performing product categories
based on total products sold.

 High-selling categories also generated strong revenue, showing strong customer demand in these segments.

 Product sales were concentrated in a few major categories, indicating that some categories drive a significant portion
of overall business performance.
*/

--3. Average Order Value
--Answer the question: “What is the average customer spending amount per order?”
SELECT
    ROUND(AVG(order_total), 2) AS average_order_value

FROM (
    SELECT
      orders.order_id,
      SUM(order_items.price + order_items.freight_value) AS order_total
    FROM
      orders
    JOIN order_items ON orders.order_id = order_items.order_id
    WHERE orders.order_status = 'delivered'
    GROUP BY orders.order_id
) AS order_totals;

/*
Insight:
 Customers spent an average of 159.83 per delivered order.
 This represents the typical transaction value across the e-commerce platform.
 */

--4. Monthly Sales Growth
--Answer the question: “What are the monthly sales growth trends?”

WITH monthly_sales AS (
    SELECT
      DATE_TRUNC('month', orders.order_purchase_timestamp) AS month,
      ROUND(SUM(order_items.price + order_items.freight_value), 2) AS total_revenue
    FROM orders
    JOIN order_items ON orders.order_id = order_items.order_id
    WHERE orders.order_status = 'delivered'
    GROUP BY month
)
SELECT 
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY month) AS previous_month_revenue,
    ROUND(((total_revenue - LAG(total_revenue) OVER(ORDER BY month))
    / LAG(total_revenue) OVER(ORDER BY month)) *100, 2) AS growth_percentage
FROM monthly_sales
ORDER BY month;

/*
Insights
Monthly sales growth showed strong upward momentum during mose periods of the dataset and
experienced several months with very high revenue growth, especially during late 2017 and 
early 2018.
Some months recorded negative growth percentages, showing temporary decline in monthly revenue.
Overall, the platform demonstrated positive long-term sales growth despite periodic fluctuation.
*/

