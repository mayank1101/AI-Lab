-- Note: please do not use any functions which are not taught in the class. you need to solve the questions only with the concepts that have been discussed so far.

-- 1. write a query to print emp name , their manager name and difference in their age (in days) for employees whose year of birth is before their managers year of birth
-- NOTE: In dates and years, a smaller number means an earlier point in time. If the employee's birth year is a smaller number than the manager's birth year, it means the employee was born first. Therefore, the employee is older.
-- MIN(dob) - returns earliest/oldest date of birth
-- MAX(dob) - returns latest/recent date of birth
SELECT
    e.emp_name AS employee_name,
    m.emp_name as manager_name,
    DATEDIFF(DAY, e.dob, m.dob) AS age_difference_days
FROM employee e
INNER JOIN employee m ON e.manager_id = m.emp_id
WHERE YEAR(e.dob) < YEAR(m.dob);

-- 2. write a query to find subcategories who never had any return orders in the month of november (irrespective of years).
SELECT 
    o.sub_category
FROM orders o
LEFT JOIN returns r ON o.order_id = r.order_id
WHERE r.order_id IS NULL AND MONTH(o.order_date) = 11;

-- 3. write a query to print manager names along with the comma separated list(order by emp salary) of all employees directly reporting to him.
SELECT
    m.emp_name as manager_name,
    STRING_AGG(e.salary, ',') WITHIN GROUP (ORDER BY e.salary) AS employee_list
FROM employee e
INNER JOIN employee m ON e.manager_id = m.emp_id
GROUP BY m.emp_name;

-- 4. write a query to get number of business days between order_date and ship_date (exclude weekends). (GOOD QUESTION)
SELECT
    order_date,
    ship_date,
    DATEDIFF(DAY, order_date, ship_date) -- Total Number of days between two order and ship dates including weekends
    - (DATEDIFF(WEEK, order_date, ship_date) * 2) -- Counts how many weekend boundaries (saturday/sunday transitions)  are cross between two order and ship dates. Since every full week contains exactly 2 weekend days (Saturday and Sunday), multiplying this count by 2 gives me the total number of weekend days to subtract
    AS no_business_days
FROM orders;

-- 5. write a query to print below 3 columns category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020).
SELECT
    category,
    SUM(
        CASE
            WHEN YEAR(order_date) = 2019 THEN sales 
        END
    ) AS total_sales_in_2019,
    SUM(
        CASE
            WHEN YEAR(order_date) = 2019 THEN sales 
        END
    ) AS total_sales_in_20120
FROM orders
GROUP BY category;

-- 6. write a query print top 5 cities in west region by average no of days between order date and ship date.
SELECT TOP 5
    city,
    AVG(DATEDIFF(DAY, order_date, ship_date)) as avg_days
FROM orders
WHERE region = 'West'
GROUP BY city
ORDER BY avg_days DESC;

-- 7. write a query to print emp name, manager name and senior manager name (senior manager is manager's manager).
SELECT
    e.emp_name AS employee_name,
    m.emp_name AS manager_name,
    sm.emp_name AS senior_manager_name
FROM employee e
INNER JOIN employee m ON e.manager_id = m.emp_id
INNER JOIN employee sm ON m.manager_id = sm.emp_id;

-- 8. write a query to print first name and last name of a customer using orders table(everything after first space can be considered as last name). (GOOD QUESTION)
SELECT
    customer_name,
    TRIM(SUBSTRING(customer_name, 1, CHARINDEX(' ', customer_name + ' ') - 1)) AS first_name, -- customer_name + ' ': Appending a space ensures the query doesn't fail if a name contains only one word (no space).
    TRIM(CASE -- To handle names without spaces by returning an empty string for the last name instead of an error or null.
        WHEN CHARINDEX(' ', customer_name) > 0
        THEN SUBSTRING(customer_name, CHARINDEX(' ', customer_name) + 1, LEN(customer_name))
    END) AS last_name
FROM orders;

-- 9. write a query to print below output using drivers table. 
-- Profit rides are the no of rides where end location and end_time of a ride is same as start location ans start time of the next ride for a driver
-- id, total_rides , profit_rides
-- dri_1, 5, 1
-- dri_2, 2, 0
-- (GOOD QUESTION)

-- FOR JOIN OUTPUT AND QUERY FRAMING USE BELOW QUERY
-- SELECT
--     *
-- FROM drivers d1
-- LEFT JOIN drivers d2 ON (d1.id = d2.id) AND (d1.end_loc = d2.start_loc) AND (d1.end_time = d2.start_time)

SELECT
    d1.id,
    COUNT(*) AS total_rides,
    COUNT(d2.id) as profit_rides
FROM drivers d1
LEFT JOIN drivers d2 ON (d1.id = d2.id) AND (d1.end_loc = d2.start_loc) AND (d1.end_time = d2.start_time)
GROUP BY d1.id;


-- 10. write a query to print customer name and no of occurence of character 'n' in the customer name. (GOOD QUESTION)
-- customer_name , count_of_occurence_of_n
SELECT
    customer_name AS customer_name,
    LEN(customer_name) - LEN(REPLACE(customer_name, 'n', '')) AS count_of_occurence_of_n
FROM orders;

-- 11. write a query to print below output from orders data. example output
-- hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
-- category , Technology, ,
-- category, Furniture, ,
-- category, Office Supplies, ,
-- sub_category, Art , ,
-- sub_category, Furnishings, ,
--and so on all the category ,subcategory and ship_mode hierarchies.
SELECT 
    category,
    SUM(
        CASE
            WHEN region = 'West' THEN sales
        END
    ) AS total_sales_in_west_region,
    SUM(
        CASE
            WHEN region = 'East' THEN sales
        END
    ) AS total_sales_in_east_region
FROM orders
GROUP BY category
UNION
SELECT 
    sub_category,
    SUM(
        CASE
            WHEN region = 'West' THEN sales
        END
    ) AS total_sales_in_west_region,
    SUM(
        CASE
            WHEN region = 'East' THEN sales
        END
    ) AS total_sales_in_east_region
FROM orders
GROUP BY sub_category
UNION
SELECT 
    ship_mode,
    SUM(
        CASE
            WHEN region = 'West' THEN sales
        END
    ) AS total_sales_in_west_region,
    SUM(
        CASE
            WHEN region = 'East' THEN sales
        END
    ) AS total_sales_in_east_region
FROM orders
GROUP BY ship_mode;


-- 12. the first 2 characters of order_id represents the country of order placed . write a query to print total no of orders placed in each country. (an order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order) <- Hint for using DISTINCT
SELECT
    LEFT(order_id, 2) AS country,
    COUNT(DISTINCT order_id) as total_orders
FROM orders
GROUP BY LEFT(order_id, 2);