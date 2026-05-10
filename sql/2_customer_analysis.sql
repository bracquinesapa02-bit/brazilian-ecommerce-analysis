--1.Repeat Customers
--Answer the question: "Which customers made more than one order?"

SELECT
    customers.customer_unique_id,
    COUNT(orders.order_id) AS total_orders
FROM
    customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_unique_id
HAVING COUNT (orders.order_id) > 1
ORDER BY total_orders DESC;

/*
Insight:
 Several customers placed multiple orders, indicating repeat purchasing behavior
  across the platform.
 The highest repeat customer placed 17 orders, while many other repeat customers made
  between 4 to 9 orders.
 This suggests the business has a segment
  of loyal and returning customers.
*/

--2.High-Value Customers
--Answer the question: "Which customers generated the highest spending?"

SELECT 
    customers.customer_unique_id,
    ROUND(SUM(order_items.price + order_items.freight_value), 2) AS total_customer_spending
FROM
    customers
JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
WHERE
    orders.order_status = 'delivered'
GROUP BY 
    customers.customer_unique_id
ORDER BY
    total_customer_spending DESC;

/*
Insights;
 A small group of customers generated significantly higher spending compared
 to the average customer base.
 The top high-value customer spent more than 13,000 across delivered orders.
 Several other customers also recorded spending above 4,000 to 7,000,
indicating the presence of premium or highly engaged customers.
 Customer spending distribution appears uneven,where a smaller segment contributes
a large portion of revenue.
*/

--3. Customer Location
--Answer the question; "Where are the customers located?"

SELECT 
    customers.customer_state,
    COUNT(customers.customer_unique_id) AS total_customers
FROM
    customers
GROUP BY 
    customers.customer_state
ORDER BY
    total_customers DESC;

/*
Insights;
-Customer distribution was heavily concentrated in a few states, particularly SP(Sao Paulo), 
RJ(Rio de Janeiro), and MG(Minas Gerais).
-SP(Sao Paulo) recorded the largest customer base with more than 41,000 customers,
significantly higher than other regions.
-Several states showed relatively low customer counts, indicating uneven
geographic customer distribution.
-The business appears to have stronger market penetration in southeastern Brazil.
*/

--4. Customer Retention
Answer the question:"How many customers returned and continued buying?"

SELECT
    COUNT(*) AS repeat_customer_count
FROM (
    SELECT
      customers.customer_unique_id
    FROM customers
    JOIN orders ON customers.customer_id = orders.customer_id
    GROUP BY customers.customer_unique_id
    HAVING COUNT(orders.order_id) > 1
) AS repeat_customers;

/*
Insight:
-The platform had 2,997 repeat customers, meaning these customers placed more than one order.
-This shows that the business was able to retain a segment of customers who returned to purchase again.
-However, repeat customers appear to represent a smaller portion of the total customer base, 
suggesting there is still room to improve customer retention.
*/

