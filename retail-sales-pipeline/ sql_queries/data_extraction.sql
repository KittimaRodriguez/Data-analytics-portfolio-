/*
Script Name: data_extraction.sql
Purpose: Extract and analyze data from the 'thelook_ecommerce.orders' table in BigQuery.
Author: Kittima Rodriguez
Created Date: 03/04/2025
Version: 1.0
Description: 
This script retrieves and analyzes retail sales data using SQL queries. 
It counts total orders, extracts sample transactions, and identifies top-selling products.
We determine which products perform best by grouping sales by product and calculating total revenue.
*/

-- 1️⃣ Count total orders to measure overall sales volume.
-- This tells us how many individual transactions occurred in the dataset.
SELECT COUNT(*) AS total_orders
FROM `bigquery-public-data.thelook_ecommerce.order_items`;

-- 2️⃣ Retrieve a sample of 10 sales transactions to understand the data structure and content.
-- This allows for a quick inspection of the dataset to verify data integrity and schema.
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.order_items`
LIMIT 10;

-- 3️⃣ Identify the top 10 best-selling products based on total revenue.
-- This query joins the `order_items` table (which contains sales transactions) 
-- with the `products` table to retrieve product names.
-- - COUNT(o.order_id): Counts the total number of orders for each product.
-- - SUM(o.sale_price): Calculates the total revenue generated by each product.
-- Sorting by total revenue in descending order helps us find the highest-selling products.
SELECT o.product_id, p.name, COUNT(o.order_id) AS total_orders, SUM(o.sale_price) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS o
JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
ON o.product_id = p.id
GROUP BY o.product_id, p.name
ORDER BY total_revenue DESC
LIMIT 10;

/*
Summary:
- Total Orders: [181518]
- Sample Transactions: Retrieved 10 sample records

| id     | order_id | user_id | product_id | status      | created_at               | shipped_at             | delivered_at           | returned_at           | sale_price |
|--------|---------|---------|------------|------------|--------------------------|------------------------|------------------------|------------------------|------------|
| 38393  | 26431   | 21138   | 14235      | Cancelled  | 2020-11-12 11:02:46 UTC  | NULL                   | NULL                   | NULL                   | 0.02       |
| 110935 | 76559   | 60981   | 14235      | Processing | 2025-02-28 14:21:22 UTC  | NULL                   | NULL                   | NULL                   | 0.02       |
| 55291  | 38088   | 30364   | 14235      | Returned   | 2024-04-25 12:39:07 UTC  | 2024-04-27 15:24:00 UTC| 2024-04-27 23:47:00 UTC| 2024-04-29 09:47:00 UTC| 0.02       |
| 92591  | 63837   | 50748   | 14159      | Complete   | 2021-10-25 04:02:56 UTC  | 2021-10-23 02:00:00 UTC| 2021-10-24 11:22:00 UTC| NULL                   | 0.49       |
| 172125 | 118944  | 94849   | 14159      | Processing | 2023-05-08 04:16:27 UTC  | NULL                   | NULL                   | NULL                   | 0.49       |
| 60138  | 41394   | 32969   | 14202      | Cancelled  | 2024-07-07 00:55:23 UTC  | NULL                   | NULL                   | NULL                   | 1.50       |
| 171741 | 118678  | 94627   | 14202      | Cancelled  | 2024-12-09 07:48:48 UTC  | NULL                   | NULL                   | NULL                   | 1.50       |
| 109734 | 75726   | 60276   | 28700      | Complete   | 2024-02-11 05:44:53 UTC  | 2024-02-11 22:31:00 UTC| 2024-02-12 18:46:00 UTC| NULL                   | 1.50       |
| 9802   | 6712    | 5394    | 28700      | Processing | 2024-10-27 07:30:47 UTC  | NULL                   | NULL                   | NULL                   | 1.50       |
| 150377 | 103813  | 82733   | 28700      | Processing | 2024-05-27 11:23:21 UTC  | NULL                   | NULL                   | NULL                   | 1.50       |

- Top 10 Best-Selling Products:
--------------------------------------
1️⃣ JORDAN DURASHEEN SHORT MENS  
2️⃣ Catherine Malandrino Women's Skinny Stretch Leather Pant  
3️⃣ Nobis Tula Parka  
4️⃣ The North Face Nuptse 2 Jacket - Noah Green/TNF Black  
5️⃣ The North Face Freedom Mens Ski Pants 2013  
6️⃣ Canada Goose Men's The Chateau Jacket  
7️⃣ Quiksilver Men's Rockefeller Walkshort  
8️⃣ NIKE WOMEN'S PRO COMPRESSION SPORTS BRA  
9️⃣ The North Face Apex Bionic Soft Shell Jacket - Men's  
🔟 Woolrich Arctic Parka DF  
*/

Next Steps:
- Perform deeper analysis on customer demographics to understand buying behavior.
- Explore sales trends over time (seasonality, daily, weekly trends).
- Investigate regional sales performance to identify high-revenue locations.
*/


