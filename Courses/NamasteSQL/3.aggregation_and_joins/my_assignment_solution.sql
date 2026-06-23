-- Note: please do not use any functions which are not taught in the class. you need to solve the questions only with the concepts that have been discussed so far.

USE analytics_bootcamp;

-- 1. write a query to get total sales for each profit group. Profit groups are defined as  
-- profit < 0 -> Loss
-- profit < 50 -> Low profit
-- profit < 100 -> High profit
-- profit >=100 -> very High profit
-- (GOOD QUESTION)
SELECT
    CASE
        WHEN profit < 0 THEN 'Loss'
        WHEN profit >= 0 AND profit < 50 THEN 'Low Profit'
        WHEN profit >= 50 AND profit < 100 THEN 'High Profit'
        WHEN profit >= 100 THEN 'High Profit'
    END as profit_groups,
    SUM(sales) AS total_sales
FROM orders
GROUP BY
    CASE
        WHEN profit < 0 THEN 'Loss'
        WHEN profit >= 0 AND profit < 50 THEN 'Low Profit'
        WHEN profit >= 50 AND profit < 100 THEN 'High Profit'
        WHEN profit >= 100 THEN 'High Profit'
    END;

-- 2. orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
-- write a query to find order ids where there is only 1 product bought by the customer.
SELECT 
    order_id
FROM orders
GROUP BY order_id
HAVING COUNT(*) = 1;

-- 3. write a query to get total profit, first order date and latest order date for each category.
SELECT
    category,
    SUM(profit) as total_profit,
    MIN(order_date) as first_order_date,
    MAX(order_date) as latest_order_date
FROM orders
GROUP BY category;

-- 4. write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category (validate the output using excel).
SELECT
    sub_category
FROM orders
GROUP BY sub_category
HAVING AVG(profit) > MAX(profit) / 2;

-- 5. create the exams table with below script;
-- create table exams (student_id int, subject varchar(20), marks int);
-- insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
-- ,(2,'Chemistry',80),(2,'Physics',90)
-- ,(3,'Chemistry',80),(3,'Maths',80)
-- ,(4,'Chemistry',71),(4,'Physics',54)
-- ,(5,'Chemistry',79);
-- write a query to find students who have got same marks in Physics and Chemistry. (GOOD QUESTION)
SELECT
    student_id,
    marks
FROM exams
WHERE subject IN ('Chemistry', 'Physics')
GROUP BY student_id, marks
HAVING COUNT(*) = 2

-- 6. write a query to find total number of products in each category.
SELECT
    category,
    COUNT(DISTINCT product_id) as total_products
FROM orders
GROUP BY category;

-- 7. write a query to find top 5 sub categories in west region by total quantity sold.
SELECT TOP 5
    sub_category,
    SUM(quantity) as total_quantity
FROM orders
WHERE region = 'West'
GROUP BY sub_category
ORDER BY total_quantity DESC;

-- 8. write a query to find total sales for each region and ship mode combination for orders in year 2020.
SELECT
    region,
    ship_mode,
    SUM(sales) as total_sales
FROM orders
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY region, ship_mode;

-- 9. write a query to get region wise count of return orders.
SELECT
    region,
    COUNT(DISTINCT r.order_id) as return_count
FROM orders o
INNER JOIN returns r ON o.order_id = r.order_id
GROUP BY region

-- 10. write a query to get category wise sales of orders that were not returned.
SELECT
    o.category,
    SUM(o.sales) as total_sales
FROM orders o
LEFT JOIN returns r ON o.order_id = r.order_id
WHERE r.order_id IS NULL
GROUP BY o.category;

-- 11. write a query to print dep name and average salary of employees in that dep.
SELECT
    d.dep_name,
    AVG(salary) as average_salary
FROM dept d
INNER JOIN employee e ON d.dep_id = e.dept_id
GROUP BY d.dep_name
ORDER BY average_salary DESC;

-- 12. write a query to print dep names where none of the emplyees have same salary (GOOD QUESTION)
SELECT 
    d.dep_name
FROM dept d
INNER JOIN employee e ON d.dep_id = e.dept_id
GROUP BY d.dep_name
HAVING COUNT(DISTINCT e.salary) = COUNT(e.salary);

-- 13. write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)
SELECT
    o.sub_category
FROM orders o
INNER JOIN returns r ON o.order_id = r.order_id
GROUP BY o.sub_category
HAVING COUNT(DISTINCT r.return_reason) = 3;

-- 14. write a query to find cities where not even a single order was returned.
SELECT
    o.city
FROM orders o
LEFT JOIN returns r ON o.order_id = r.order_id
GROUP BY o.city
HAVING COUNT(r.order_id) = 0;

-- 15. write a query to find top 3 subcategories by sales of returned orders in east region
SELECT TOP 3
    o.sub_category,
    SUM(o.sales) AS return_sales
FROM orders o
INNER JOIN returns r ON o.order_id = r.order_id
WHERE o.region = 'East'
GROUP BY o.sub_category
ORDER BY return_sales DESC;

-- 16. write a query to print dep name for which there is no employee.
SELECT
    d.dep_name
FROM dept d
LEFT JOIN employee e ON d.dep_id = e.dept_id
WHERE e.emp_id is NULL;

-- 17. write a query to print employees name for which dep id is not present in dept table
SELECT
    e.emp_name
FROM employee e
LEFT JOIN dept d ON e.dept_id = d.dep_id
WHERE d.dep_id IS NULL;

-- 18. write a query to print 3 columns : category, total_sales and (total sales of returned orders) (GOOD QUESTION)
SELECT
    o.category,
    SUM(o.sales) as total_sales,
    SUM(
        CASE
            WHEN r.order_id IS NOT NULL THEN o.sales
        END
    ) AS return_sales
FROM orders o
LEFT JOIN returns r ON o.order_id = r.order_id
GROUP BY o.category;