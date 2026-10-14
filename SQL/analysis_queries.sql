USE retail_sales;
-- 1. Total sales, profit and number of orders
SELECT ROUND(SUM(sales),2) AS total_sales,
       ROUND(SUM(profit),2) AS total_profit,
       COUNT(DISTINCT order_id) AS total_orders
FROM superstore;

-- 2. Sales and profit by category
SELECT category,
       ROUND(SUM(sales),2) AS total_sales,
       ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- 3. Sales and profit by region, best to worst
SELECT region,
       ROUND(SUM(sales),2) AS total_sales,
       ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit DESC;

-- 4. Sub-categories that lose money
SELECT sub_category,
       ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit;

-- 5. Monthly sales trend
SELECT YEAR(order_date) AS yr,
       MONTH(order_date) AS mth,
       ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY yr, mth;
-- 6. Discount band vs profit
SELECT CASE
         WHEN discount = 0 THEN '0%'
         WHEN discount <= 0.2 THEN '1-20%'
         WHEN discount <= 0.4 THEN '21-40%'
         ELSE 'Above 40%'
       END AS discount_band,
       COUNT(*) AS line_items,
       ROUND(SUM(sales),2) AS total_sales,
       ROUND(SUM(profit),2) AS total_profit,
       ROUND(SUM(profit)/SUM(sales)*100,2) AS margin_pct
FROM superstore
GROUP BY discount_band
ORDER BY MIN(discount);

-- 7. Top 10 loss-making products
SELECT product_name,
       ROUND(SUM(sales),2) AS total_sales,
       ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY SUM(profit)
LIMIT 10;
-- 8. Top 10 customers by sales
SELECT customer_name,
       COUNT(DISTINCT order_id) AS orders,
       ROUND(SUM(sales),2) AS total_sales,
       ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- 9. How many order lines lose money?
SELECT COUNT(*) AS loss_lines,
       ROUND(SUM(profit),2) AS total_loss
FROM superstore
WHERE profit < 0;
