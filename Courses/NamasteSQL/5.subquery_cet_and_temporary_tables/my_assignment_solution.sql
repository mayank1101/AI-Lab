-- Note: please do not use any functions which are not taught in the class. you need to solve the questions only with the concepts that have been discussed so far.

-- 1. write a query to find premium customers from orders data. Premium customers are those who have done more orders than average no of orders per customer.
WITH customer_orders AS
(
    SELECT
        customer_id as PREMIUM_CUSTOMERS,
        COUNT(DISTINCT order_id) as ORDER_COUNT_PER_CUSTOMER
    FROM orders
    GROUP BY customer_id
)
SELECT
    *
FROM customer_orders
WHERE ORDER_COUNT_PER_CUSTOMER > (
    SELECT AVG(ORDER_COUNT_PER_CUSTOMER) as AVG_ORDER_PER_CUSTOMER
    FROM customer_orders
);

-- 2. write a query to find employees whose salary is more than average salary of employees in their department

-- Using CTE
WITH dept_avg_salary AS
(
    SELECT
        dept_id,
        AVG(salary) as avg_salary
    FROM employee
    GROUP BY dept_id

)
SELECT
    e.emp_id,
    e.emp_name,
    e.salary
FROM employee e
INNER JOIN dept_avg_salary d ON e.dept_id = d.dept_id
WHERE e.salary > d.avg_salary;

-- Using Subquery
SELECT
    e.emp_id,
    e.emp_name,
    e.salary
FROM employee e
INNER JOIN (
    SELECT
        dept_id,
        AVG(salary) as avg_salary
    FROM employee
    GROUP BY dept_id
) d ON e.dept_id = d.dept_id
WHERE e.salary > d.avg_salary;

-- 3. write a query to find employees whose age is more than average age of all the employees

-- Using CTE
WITH employee_avg_age AS
(
    SELECT
        AVG(emp_age) as avg_age
    FROM employee
)
SELECT
    emp_id,
    emp_name,
    emp_age
FROM employee
WHERE emp_age > (
    SELECT
        avg_age
    FROM employee_avg_age
)

-- Using Subquery
SELECT
    emp_id,
    emp_name,
    emp_age
FROM employee
WHERE emp_age > (
    SELECT
        AVG(emp_age) as avg_age
    FROM employee
);

-- 4. write a query to print emp name, salary and dep id of highest salaried employee in each department.

-- Using CTE
WITH dept_wise_highest_salary AS
(
    SELECT
        dept_id,
        MAX(salary) as highest_salary
    FROM employee
    GROUP BY dept_id
)
SELECT
    e.emp_id,
    e.emp_name,
    e.salary
FROM employee e
INNER JOIN dept_wise_highest_salary d ON e.dept_id = d.dept_id
WHERE e.salary = d.highest_salary;

-- Using Subquery
SELECT
    e.emp_id,
    e.emp_name,
    e.salary
FROM employee e
INNER JOIN (
    SELECT
        dept_id,
        MAX(salary) as highest_salary
    FROM employee
    GROUP BY dept_id
) d ON e.dept_id = d.dept_id
WHERE e.salary = d.highest_salary;

-- 5. write a query to print emp name, salary and dep id of highest salaried employee overall.

-- Using CTE
WITH highest_employee_salary AS
(
    SELECT
        MAX(salary) as highest_salary
    FROM employee
)
SELECT
    emp_name,
    salary,
    dept_id
FROM employee
WHERE salary = (
    SELECT 
        highest_salary
    FROM highest_employee_salary
)

-- Using Subquery
SELECT
    emp_name,
    salary,
    dept_id
FROM employee
WHERE salary = (
    SELECT
        MAX(salary)
    FROM employee
);

-- 6. write a query to print product id and total sales of highest selling products (by no of units sold) in each category (GOOD QUESTION)

-- CTE
WITH category_wise_product_units_sold AS
(
    SELECT
        category,
        product_id,
        SUM(quantity) as units_sold
    FROM orders
    GROUP BY category, product_id
),
category_wise_max_selling_product AS 
(
    SELECT
        category,
        MAX(units_sold) as highest_selling
    FROM category_wise_product_units_sold
    GROUP BY category
)
SELECT
    us.category,
    us.product_id,
    us.units_sold
FROM category_wise_product_units_sold us
INNER JOIN category_wise_max_selling_product msp ON us.category = msp.category
WHERE us.units_sold = highest_selling;

-- Using Subquery
SELECT
    us.category,
    us.product_id,
    us.units_sold
FROM
(
    SELECT
        category,
        product_id,
        SUM(quantity) as units_sold
    FROM orders
    GROUP BY category, product_id
) us
INNER JOIN 
(
    SELECT
        category,
        MAX(units_sold) as highest_selling
    FROM 
    (
        SELECT
            category,
            product_id,
            SUM(quantity) as units_sold
        FROM orders
        GROUP BY category, product_id
    ) t
    GROUP BY category
) hsp 
ON us.category = hsp.category
WHERE us.units_sold = hsp.highest_selling;

-- 7. Run below table script to create icc_world_cup table:
-- create table icc_world_cup
-- (
-- Team_1 Varchar(20),
-- Team_2 Varchar(20),
-- Winner Varchar(20)
-- );
-- INSERT INTO icc_world_cup values('India','SL','India');
-- INSERT INTO icc_world_cup values('SL','Aus','Aus');
-- INSERT INTO icc_world_cup values('SA','Eng','Eng');
-- INSERT INTO icc_world_cup values('Eng','NZ','NZ');
-- INSERT INTO icc_world_cup values('Aus','India','India');

-- write a query to produce below output from icc_world_cup table. (GOOD QUESTION)
-- team_name, no_of_matches_played , no_of_wins , no_of_losses

-- Using CTE
WITH all_teams AS -- In this table, we create all teams list such that every team has one row per match played
(
    SELECT
        Team_1 as team_name,
        Winner
    FROM icc_world_cup
    UNION ALL
    SELECT
        Team_2 as team_name,
        Winner
    FROM icc_world_cup
)
SELECT
    team_name,
    COUNT(*) AS no_of_matches_played,
    SUM
    (
        CASE
            WHEN team_name = Winner THEN 1
            ELSE 0
        END
    ) AS no_of_wins,
    SUM
    (
        CASE
            WHEN team_name != Winner THEN 1
            ELSE 0
        END
    ) AS no_of_losses
FROM all_teams
GROUP BY team_name
ORDER BY no_of_wins DESC;

-- Using Subquery
SELECT
    team_name,
    COUNT(*) AS no_of_matches_played,
    SUM
    (
        CASE
            WHEN team_name = Winner THEN 1
            ELSE 0
        END
    ) AS no_of_wins,
    SUM
    (
        CASE
            WHEN team_name != Winner THEN 1
            ELSE 0
        END
    ) AS no_of_losses
FROM
(
    SELECT
        Team_1 as team_name,
        Winner
    FROM icc_world_cup
    UNION ALL
    SELECT
        Team_2 as team_name,
        Winner
    FROM icc_world_cup
) t -- In this table, we create all teams list such that every team has one row per match played
GROUP BY team_name
ORDER BY no_of_wins DESC;

-- 8. https://www.namastesql.com/coding-problem/38-product-reviews
SELECT
	*
FROM product_reviews
WHERE (LOWER(review_text) LIKE '%excellent%' OR LOWER(review_text) LIKE '%amazing%') 
	   AND (LOWER(review_text) NOT LIKE '%not excellent%')
	   AND (LOWER(review_text) NOT LIKE '%not amazing%');

-- 9. https://www.namastesql.com/coding-problem/61-category-sales-part-1
SELECT
	category,
	SUM(amount) as total_sales
FROM sales
WHERE YEAR(order_date) = 2022 AND MONTH(order_date) = 2 AND DATEPART(WEEKDAY, order_date) BETWEEN 2 AND 6
GROUP BY category
ORDER BY total_sales ASC;

-- 10. https://www.namastesql.com/coding-problem/62-category-sales-part-2
SELECT
	c.category_name,
	SUM(
		CASE
			WHEN s.sale_id IS NULL THEN 0
			ELSE s.amount
		END
	) AS total_sales
FROM categories c
LEFT JOIN sales s ON c.category_id = s.category_id
GROUP BY c.category_name
ORDER BY total_sales ASC;

-- 11. https://www.namastesql.com/coding-problem/71-department-average-salary
SELECT
	d.department_name,
	ROUND(AVG(e.salary * 1.0), 2) AS average_salary
FROM employees e
INNER JOIN departments d
ON
	e.department_id = d.department_id
GROUP BY d.department_name
HAVING COUNT(*) >= 2

-- 12. https://www.namastesql.com/coding-problem/72-product-sales
SELECT
	p.product_name,
	SUM(s.quantity * p.price) as total_sales_amount
FROM products p
INNER JOIN sales s
ON
	p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY p.product_name

-- 13. https://www.namastesql.com/coding-problem/73-category-product-count (GOOD QUESTION)
SELECT
	category,
	ROUND((LENGTH(products) - LENGTH(REPLACE(products, ', ', ''))) / 2 + 1, 0) AS product_count
FROM categories
GROUP BY category, product_count
ORDER BY product_count, category; 

-- 14. https://www.namastesql.com/coding-problem/103-employee-mentor
SELECT
	name
FROM employees
WHERE mentor_id != 3 OR mentor_id IS NULL;

-- 15. https://www.namastesql.com/coding-problem/8-library-borrowing-habits (GOOD QUESTION)
SELECT
	bor.BorrowerName,
	GROUP_CONCAT(b.BookName ORDER BY b.BookName ASC SEPARATOR ', ') AS BooksBorrowed
FROM Borrowers bor
INNER JOIN Books b ON bor.BookID = b.BookID
GROUP BY bor.BorrowerName
ORDER BY bor.BorrowerName ASC;

-- 16.(GOOD QUESTION - CTE CONCEPT) https://www.namastesql.com/coding-problem/52-loan-repayment
WITH loan_payment_summary AS
(
	SELECT
		lo.loan_id,
		lo.loan_amount,
		lo.due_date,
		SUM(py.amount_paid) AS total_paid,
		MAX(py.payment_date) AS last_payment_date
	FROM loans lo
	LEFT JOIN Payments py 
		ON lo.loan_id = py.loan_id
	GROUP BY
		lo.loan_id,
		lo.loan_amount,
		lo.due_date
	
)
SELECT
	loan_id,
	loan_amount,
	due_date,
	CASE
		WHEN total_paid >= loan_amount THEN 1
		ELSE 0
	END AS fully_paid_flag,
	CASE
		WHEN last_payment_date <= due_date THEN 1
		ELSE 0
	END AS on_time_flag
FROM loan_payment_summary;

-- 17. (GOOD QUESTION - COALESCE CONCEPT) https://www.namastesql.com/coding-problem/55-lowest-price
SELECT
	pr.category,
	COALESCE
	(
		MIN(
			CASE
				WHEN pu.stars >= 4 THEN pr.price
			END
		),
		0
	) AS minimum_product_price
FROM products pr
LEFT JOIN purchases pu
	ON pr.id = pu.product_id
GROUP BY pr.category
ORDER BY pr.category;
