COPY customers
FROM 'C:/csv_files/olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY order_items
FROM 'C:/csv_files/olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY orders
FROM 'C:/csv_files/olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY products
FROM 'C:/csv_files/olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY category_translation
FROM 'C:/csv_files/product_category_name_translation.csv'
DELIMITER ','
CSV HEADER;

COPY order_reviews
FROM 'C:/csv_files/olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;
