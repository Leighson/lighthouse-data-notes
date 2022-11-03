SELECT count(*) FROM orders;
SELECT min(orderdate) FROM orders;
SELECT max(orderdate) FROM orders;

/* It's good practice to put 'drop table if exists' before each
table creation. This will eliminate errors when rerunning the script
and doesn't do anything if the table doesn't exists syet. */
DROP TABLE if exists end_obs_dates;
CREATE TABLE end_obs_dates
AS

/* Recursive query example
(similar to FOR loop for SQL) */
WITH RECURSIVE
  cnt(x) AS (
     SELECT 0
     UNION ALL
     SELECT x+1 FROM cnt
     LIMIT (SELECT ROUND(((julianday('1998-06-01') - julianday('1996-08-01'))/30) + 1)) -- this counts number of months between these two days
  )
SELECT date('1996-08-01', '+' || x || ' month') as end_obs_date FROM cnt;

/* create ADS POPULATION HIST (each customer id for each month), we will use table customers for this */
DROP TABLE if exists ads_population_hist;

CREATE TABLE ads_population__hist
AS
SELECT A.*, B.*
FROM end_obs_date AS A
CROSS JOIN (SELECT DISTINCT customerid FROM customers) AS B;

SELECT * FROM ads_population_hist LIMIT 10;