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

SELECT
    product_name,
    group_name,
    ROUND(AVG (price) OVER w, 2) AS avg_price,
    ROUND(SUM (price) OVER w, 2) AS total_price,
    ROUND(COUNT (price) OVER w, 0) AS count
FROM products
INNER JOIN product_groups USING (group_id)
WINDOW w AS (PARTITION BY group_name);

/* WINDOW allows you to reuse repeating window functions for multiple
partitions */

/* Use this website for further reference:
https://www.postgresqltutorial.com/postgresql-window-function/ */