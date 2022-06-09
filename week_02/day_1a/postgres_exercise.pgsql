/* SQL Exercise
====================================================================
We will be working with database northwind.db we have set up and connected to in the activity Connect to Remote PostgreSQL Database earlier.


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE
*/
SELECT * FROM products;
SELECT * FROM categories;
SELECT * FROM suppliers;
SELECT * FROM region;
SELECT * FROM territories;
SELECT * FROM usstates;
SELECT * FROM order_details;
SELECT * FROM employees;

--==================================================================
/* TASK I
-- Q1. Write a query to get Product name and quantity/unit.
*/
SELECT productname, quantityperunit FROM products;

/* TASK II
Q2. Write a query to get the most expensive and the least expensive Product (name and unit price) (2 separate queries)
*/
SELECT productname,unitprice FROM products
 ORDER BY unitprice
 LIMIT 1;

SELECT productname,unitprice FROM products
 ORDER BY unitprice DESC
 LIMIT 1;

/* TASK III
Q3. Write a query to count current and discontinued products.
*/
SELECT CASE WHEN discontinued=1 THEN 'YES'
            ELSE 'NO'
             END AS discontinued, COUNT(*)
  FROM products
 GROUP BY discontinued;

/* TASK IV
Q4. Select all product names and their category names (77 rows)
*/
SELECT products.productname, categories.description FROM products
  JOIN categories ON categories.categoryid=products.categoryid;

/* TASK V
Q5. Select all product names, unit price and the supplier region that don't have suppliers from the country USA. (65 rows)
*/
SELECT products.productname, products.unitprice, suppliers.region FROM products
  JOIN suppliers ON suppliers.supplierid=products.supplierid
 WHERE suppliers.supplierid IN
   (SELECT suppliers.supplierid FROM suppliers
     WHERE suppliers.country != 'USA');

/* TASK VI
Q6. Get the total quantity of orders sold.( 51317)
*/
SELECT SUM(quantity) AS Total_Orders FROM order_details;

/* TASK VII
Q7. Get the total quantity of orders sold for each order.(830 rows)
*/
SELECT orderid, SUM(quantity) AS Each_Order FROM order_details
 GROUP BY orderid ORDER BY orderid;

/* TASK VIII
Q8. Get the number of employees who have been working more than 5 year in the company. (9 rows)
*/
SELECT employees.firstname || ' ' || employees.lastname, hiredate, current_date FROM employees
 WHERE DATE_PART('day', employees.hiredate::timestamp - CURRENT_DATE) < 5;


SELECT CURRENT_DATE, employees.hiredate, (CURRENT_TIMESTAMP - employees.hiredate) AS difference from employees;

SELECT to_timestamp(employees.hiredate - CURRENT_DATE)::date FROM employees;

select extract(epoch from employees.hiredate) FROM employees;

SELECT (AGE(employees.hiredate))::date from employees;

show datestyle;