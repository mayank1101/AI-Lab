-- 1. write a sql to get all the orders where customers name has "a" as second character and "d" as fourth character (58 rows)
SELECT *
FROM orders
WHERE customer_name LIKE '_a_d%';

-- 2. write a sql to get all the orders placed in the month of dec 2020 (352 rows) 
SELECT *
FROM orders
WHERE order_date BETWEEN '2020-12-01' AND '2020-12-31'; 

-- 3. write a query to get all the orders where ship_mode is neither in 'Standard Class' nor in 'First Class' and ship_date is after nov 2020 (944 rows)
SELECT *
FROM orders
WHERE ship_mode NOT IN ('Standard Class', 'First Class') AND ship_date >= '2020-12-01';

-- 4. write a query to get all the orders where customer name does not start with "A" but ends with "n" (2222 rows)
SELECT *
FROM orders
WHERE customer_name LIKE '[^A]%n';

-- 5. write a query to get all the orders where profit is negative (1871 rows)
SELECT *
FROM orders
WHERE profit < 0;

-- 6. write a query to get all the orders where either quantity is less than 3 or profit is 0 (3348)
SELECT *
FROM orders
WHERE quantity < 3 OR profit = 0;

-- 7. your manager handles the sales for South region and he wants you to create a report of all the orders in his region where some discount is provided to the customers (815 rows)
SELECT *
FROM orders
WHERE region = 'South' AND discount > 0;

-- 8. write a query to find top 5 rows with highest sales in furniture category 
SELECT TOP 5 *
FROM orders
WHERE category = 'Furniture'
ORDER BY sales DESC;

-- 9. write a query to find all the records in technology and furniture category for the orders placed in the year 2020 only (1021 rows)
SELECT *
FROM orders
WHERE category IN ('Technology', 'Furniture') AND order_date BETWEEN '2020-01-01' AND '2020-12-31';

-- 10. write a query to find all the orders where order date is in year 2020 but ship date is in 2021 (33 rows)
SELECT *
FROM orders
WHERE (order_date BETWEEN '2020-01-01' AND '2020-12-31') AND (ship_date BETWEEN '2021-01-01' AND '2021-12-31');

-- 11. You have a table of customers where the gender column values are wrongly populated . Write an update statement to swap the gender. The male should be update to female and female should be updated to male.
-- create table  customers 
-- (
-- customer_id int,
-- gender varchar(1)
-- )
-- insert into customers values (1,'M') , (2,'F') , (3,'F') , (4,'M')
UPDATE customers
SET gender = CASE
    WHEN gender = 'F' then 'M'
    WHEN gender = 'M' then 'F'
    ELSE gender
END