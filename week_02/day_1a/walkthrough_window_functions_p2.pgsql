/* example from
https://www.postgresqltutorial.com/postgresql-window-function/ */
SELECT * FROM product_groups;
SELECT * FROM products;

SELECT ROUND(AVG (price), 2) FROM products
INNER JOIN product_groups USING (group_id)
GROUP BY group_name;

SELECT
    product_name,
    price,
    group_name,
    ROUND(AVG (price) OVER (PARTITION BY group_name), 2) AS avg_price
FROM products
INNER JOIN product_groups USING (group_id);