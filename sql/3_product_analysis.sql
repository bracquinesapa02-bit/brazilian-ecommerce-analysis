--1. Top Selling Products
--Answer the question: "Which product categories sell the most?"

SELECT
     category_translation.product_category_name_english AS product_category,
    COUNT(order_items.product_id) AS total_products_sold,
    ROUND(SUM(order_items.price), 2) AS total_revenue
FROM
    products
JOIN order_items ON products.product_id = order_items.product_id
JOIN orders ON order_items.order_id = orders.order_id
LEFT JOIN category_translation ON products.product_category_name = category_translation.product_category_name
WHERE 
    orders.order_status = 'delivered'
GROUP BY
    category_translation.product_category_name_english
ORDER BY
    total_products_sold DESC;

/*
Insight:
-Bed bath table, health beauty, and sports leisure were the top-selling
product categories based on total products sold.
-Health beauty and watches gifts generated particularly strong revenue,
indicating high customer demand and strong product performance.
-Product sales were concentrated among several dominant categories,
while many smaller categories contributed lower overall sales volume.
-The results suggest that home-related, lifestyle, and personal care products
play a major role in the platform’s revenue.
*/

--2. Underperforming Products
--Answer the question: "Which product categories have the lowest sales performance?"

SELECT
    category_translation.product_category_name_english AS product_category,
    COUNT(order_items.product_id) AS total_products_sold,
    ROUND(SUM(order_items.price), 2) AS total_revenue
FROM
    products
JOIN order_items ON products.product_id = order_items.product_id
JOIN orders ON order_items.order_id = orders.order_id
LEFT JOIN category_translation ON products.product_category_name = category_translation.product_category_name
WHERE
    orders.order_status = 'delivered'
GROUP BY
    category_translation.product_category_name_english
ORDER BY
    total_products_sold ASC;

/*
nsight:
-Several product categories recorded very low sales volume and revenue,
indicating weak customer demand.
-Categories such as security and services, fashion children clothes,
and cds dvds musicals were among the lowest-performing products.
-These categories may require better marketing, product optimization,
or inventory evaluation to improve performance.
*/

--3. Product Category Profitablity
--Answer the question: "Which product categories generate the highest revenue?"

SELECT
    category_translation.product_category_name_english AS product_category,
    ROUND(SUM(order_items.price), 2) AS total_revenue,
    ROUND(AVG(order_items.price), 2) AS average_product_price
FROM
    products
JOIN order_items ON products.product_id = order_items.product_id
JOIN orders ON order_items.order_id = orders.order_id
LEFT JOIN category_translation ON products.product_category_name = category_translation.product_category_name
WHERE
    orders.order_status = 'delivered'
GROUP BY
    category_translation.product_category_name_english
ORDER BY 
    total_revenue DESC;

/*
Insight:
-Health beauty, watches gifts, and bed bath table generated
the highest total revenue among product categories.
-Some categories such as computers and musical instruments had significantly
higher average product prices, despite lower total revenue.
-Categories with both high sales volume and strong revenue indicate
consistently strong customer demand.
-The results show that profitability differs across categories depending on
product pricing and sales volume.
*/
