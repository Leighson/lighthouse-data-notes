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