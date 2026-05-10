--1. Low-Rated Products
--Answer the question: "Which product categories receive the lowest review scores?"

SELECT
    category_translation.product_category_name_english AS product_category,
    ROUND(AVG(order_reviews.review_score), 2) AS average_review_score,
    COUNT(order_reviews.review_id) AS total_reviews
FROM 
    order_reviews
JOIN orders ON order_reviews.order_id = orders.order_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
LEFT JOIN category_translation ON products.product_category_name = category_translation.product_category_name
GROUP BY
    category_translation.product_category_name_english
ORDER BY
    average_review_score ASC;
/*
Insight:
-Several product categories received relatively low customer review scores,
indicating weaker customer satisfaction.
-Security and services recorded the lowest average review score,
followed by diapers and hygie and office furniture.
-Office furniture had both a low review score and a high number of reviews,
suggesting recurring customer experience issues within that category.
-Some low-rated categories had only a small number of reviews,
meaning their ratings may be less stable due to limited customer feedback.
*/

--2.Seller satisfaction 
--Answer the question: "Which sellers receive the highest and lowest customer review scores?"

SELECT
    order_items.seller_id,
    ROUND(AVG(order_reviews.review_score), 2) AS average_review_score,
    COUNT(order_reviews.review_id) AS total_reviews
FROM 
    order_reviews
JOIN orders ON order_reviews.order_id = orders.order_id
JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY
    order_items.seller_id
ORDER BY 
    average_review_score ASC;

/*
Insight:
-Several sellers received extremely low average review scores of 1.00,
indicating very poor customer satisfaction.
-However, many of these sellers had only a small number of reviews,
which may make their ratings less reliable.
-Sellers with consistently low ratings may be experiencing issues related to
product quality, delivery performance, or customer service.
-Monitoring seller review performance is important to maintain overall
platform reputation and customer trust.
*/

--3.Delivery Impact on Ratings
--Answer the question: "Do delayed deliveries lead to lower customer review scores?"

-- 3. Delivery Impact on Ratings

SELECT
    CASE
     WHEN orders.order_delivered_customer_date
             >
             orders.order_estimated_delivery_date
        THEN 'Delayed Delivery' ELSE 'On-Time Delivery'
    END AS delivery_status,

    ROUND(AVG(order_reviews.review_score), 2) AS average_review_score,
    COUNT(order_reviews.review_id) AS total_reviews
FROM
    orders
JOIN order_reviews ON orders.order_id = order_reviews.order_id
WHERE
    orders.order_status = 'delivered'
GROUP BY 
    delivery_status;

/*
Insight:
-Delivery performance had a strong impact on customer review ratings.
-Orders with delayed delivery received a much lower average review score
of 2.57.
-In contrast, on-time deliveries achieved a significantly higher average review score
of 4.29.
-The results clearly suggest that shipping delays negatively affect
customer satisfaction and review behavior.
-Maintaining fast and reliable delivery is important for improving customer experience
and platform reputation.
*/
