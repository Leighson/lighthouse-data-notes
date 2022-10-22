/* Task 1 */
SELECT
    products.productname,
    products.quantityperunit
FROM products
WHERE products.productname = 'Chai';

/* Task 2 */
SELECT
    products.productname,
    products.categoryid
FROM products;

/* Task 3 */
SELECT
    CONCAT(employees.firstname, ' ', employees.lastname) AS Employee_Name,
    employees.birthdate,
    employees.hiredate,
    DATE_PART('year', CURRENT_DATE) - DATE_PART('year', employees.hiredate) AS Years_Hired,
    DATE_PART('year', employees.hiredate) - DATE_PART('year', employees.birthdate) AS Age
FROM employees
WHERE DATE_PART('year', CURRENT_DATE) - DATE_PART('year', employees.hiredate) < 30;

/* WINDOW FUNCTIONS */
/* OVER specifies that the aggregate function SUM is a window or analytic function rather than an aggregate,
meaning that it returns a full output rather than a folded output in the case of GROUP BY */

SELECT 
    products.productname,
    SUM(products.unitprice)
        OVER (ORDER BY products.productid) AS running_total
FROM products;

/* PARTITION BY subdivides the window function into its respective groups
and calculates the aggregate function within each subdivision. Partitions are sensitive to row order
so make sure to ORDER BY appropriately, otherwise, the query may return erroneous results. */

SELECT
    products.productname,
    products.categoryid,
    ROUND(AVG(products.unitsinstock)
        OVER (PARTITION BY products.categoryid ORDER BY products.categoryid), 2) AS avg_avail,
    ROUND(SUM(products.unitsinstock)
        OVER (PARTITION BY products.categoryid ORDER BY products.categoryid), 0) AS sum_avail,
    ROUND(COUNT(products.unitsinstock)
        OVER (PARTITION BY products.categoryid ORDER BY products.categoryid), 0) AS count_avail
FROM products;

/* ROW NUMBER displays the number of a given row. It starts at 1 and numbers the rows according
to the ORDER BY part of the window statement. */

SELECT
    ROW_NUMBER() OVER (ORDER BY products.productid) AS row,
    products.productname,
    products.categoryid
FROM products;

/* RANK also displays the number of a given row, but in the case that some rows
with two identical values in the ordered column, they are given the same rank.
DENSE RANK behaves similarly to RANK but continues numbering in order rather than
remembering the ordering number of each ranked skipped. */

SELECT
    RANK() OVER(PARTITION BY products.categoryid
        ORDER BY products.unitsinstock) AS rank,
    products.productname,
    products.categoryid
FROM products;

SELECT
    DENSE_RANK() OVER(PARTITION BY products.categoryid
        ORDER BY products.unitsinstock) AS dense_rank,
    products.productname,
    products.categoryid
FROM products;

/* NTILE is used to identify what percentile (or quartile or any other subdivision) a given row
falls into. In this case, ORDEER BY determines which column to useb to determine the quartiles.
The syntax requires that the number of boxes be specified to determine the percentiles.*/

SELECT
    products.productid,
    products.productname,
    products.unitprice,
    NTILE(4) OVER(
        PARTITION BY products.categoryid ORDER BY products.unitprice) AS quartile,
    NTILE(10) OVER(
        PARTITION BY products.categoryid ORDER BY products.unitprice) AS decatile
FROM products ORDER BY products.categoryid;

SELECT MIN(products.unitprice), MAX(products.unitprice) FROM products;

/* LAG and LEAD can often be useful to compare rows to preceding or following rows,
especially if the data is in an order for comparisons to make sense. The syntax requires
that the amount of LAG or LEAD is specified with the column to be compared. 0 returns the 
current row. */

SELECT
    products.productid,
    products.productname,
    products.categoryid,
    products.unitprice,
    LAG(products.unitprice, 1) OVER(
        PARTITION BY products.categoryid ORDER BY products.unitprice) AS lag_1,
    LEAD(products.unitprice, 2) OVER(
        PARTITION BY products.categoryid ORDER BY products.unitprice) AS lead_2,
    products.unitprice - LAG(products.unitprice, 1) OVER(
        PARTITION BY products.categoryid ORDER BY products.unitprice) AS comparison
FROM products;