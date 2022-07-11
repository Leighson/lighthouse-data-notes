/*Introduction to PostgreSQL window functions*/

-- Example queries for the database
SELECT * FROM products LIMIT 10;
SELECT * FROM product_group;

-- Applying a groupby aggregate function
SELECT group_name, AVG(price) FROM products
 INNER JOIN product_groups USING (group_id)
 GROUP BY group_name;

/*The aggregate function reduces the number of rows returned by
queries in both examples*/

-- However, window functions do not.
-- Note the syntax: AVG(price) OVER (PARTITION BY group_name)
SELECT
        product_name,
        price,
        group_name,
        AVG(price) OVER(
            PARTITION BY group_name
        )
FROM
        products
        INNER JOIN
                product_groups USING (group_id);

/*Also note that a window function always performs the calculation on the
set after the JOIN, WHERE, GROUP BY, and HAVING clause and before the final
ORDER BY clause in the evaluation order*/

/*PostrgreSQL Window Function Syntax*/

-- The simplified window_function call:
-- window_function(arg1, arg2, ...) OVER (
--      [PARTITION BY partition_expression]
--      [ORDER BY sort_expression [ASC | DESC] [NULLS {FIRST | LAST}]])

