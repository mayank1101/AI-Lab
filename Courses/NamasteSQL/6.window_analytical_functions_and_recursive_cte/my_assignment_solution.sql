-- Note: please do not use any functions which are not taught in the class. you need to solve the questions only with the concepts that have been discussed so far.

-- 1. write a query to print 3rd highest salaried employee details for each department (give preferece to younger employee in case of a tie). 
-- In case a department has less than 3 employees then print the details of highest salaried employee in that department.
-- (GOOD QUESTION)

WITH employee_ranks AS
(
    SELECT
        *,
        DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC, emp_age) AS salary_rank, -- assign ranks to employees based on salaries
        ROW_NUMBER() OVER(PARTITION BY dept_id, salary ORDER BY emp_age ASC) AS age_pref -- to handle salary tie, we use emp_age
    FROM employee
),
dept_wise_emp_count AS (
    SELECT
        dept_id,
        COUNT(*) as emp_count -- emp count department wise
    FROM employee
    GROUP BY dept_id
)
SELECT
    er.*
FROM employee_ranks er
INNER JOIN dept_wise_emp_count dc 
    ON er.dept_id = dc.dept_id  
WHERE 
    (
        dc.emp_count >= 3
        AND er.salary_rank = 3
        AND er.age_pref = 1
    )
OR
    (
        dc.emp_count < 3
        AND er.salary_rank = 1
        AND er.age_pref = 1
    )

-- 2. write a query to find top 3 and bottom 3 products by sales in each region.
WITH product_sales_rank AS
(
    SELECT
        *,
        DENSE_RANK() OVER(PARTITION BY region ORDER BY sales DESC) AS top_sales_rank,
        DENSE_RANK() OVER(PARTITION BY region ORDER BY sales ASC) AS bottom_sales_rank
    FROM orders
)
SELECT
    *
FROM product_sales_rank
WHERE top_sales_rank <=3 OR bottom_sales_rank <= 3;

-- 3. Among all the sub categories. which sub category had highest month over month growth by sales in Jan 2020 compare to previous month (Dec 2019)
-- (GOOD QUESTION)
WITH monthly_sales AS 
(
    SELECT
        sub_category,
        DATETRUNC(MONTH, order_date) as order_month, -- DATETRUNC FASTER THEN FORMAT. It Rounds a timestamp down to the first day of its month. Mapping - 2019-12-20 -> 2019-12-01
        SUM(sales) as sales
    FROM orders
    WHERE DATETRUNC(MONTH, order_date) IN ('2019-12-01', '2020-01-01')
    GROUP BY sub_category, DATETRUNC(MONTH, order_date)
),

previous_month_sales AS
(
    SELECT
        *,
        LAG(sales, 1) OVER(PARTITION BY sub_category ORDER BY order_month) AS prev_sales -- LAG(column_name, offset=1, default_value=NULL)
    FROM monthly_sales

)

SELECT
    *,
    ((sales - prev_sales) * 100) / prev_sales  as mom_growth
FROM previous_month_sales
WHERE order_month = '2020-01-01'
ORDER BY mom_growth DESC;

-- 4. write a query to print top 3 products in each category by year over year sales growth in year 2020.
-- (GOOD QUESTION)
WITH year_sales AS 
(
    SELECT
        category,
        product_id,
        YEAR(order_date) as order_year,
        SUM(sales) as sales
    FROM orders
    GROUP BY category, product_id, YEAR(order_date)
),

previous_year_sales AS 
(
    SELECT
        *,
        LAG(sales, 1) OVER(PARTITION BY category, product_id ORDER BY order_year) AS prev_year_sales
    FROM year_sales
),

sales_rank AS 
(
    SELECT
        *,
        DENSE_RANK() OVER(PARTITION BY category ORDER BY (sales - prev_year_sales) / prev_year_sales DESC) AS product_rank
    FROM previous_year_sales
    WHERE order_year='2020'
)

SELECT
    *
FROM sales_rank
WHERE product_rank <= 3;

-- 5. write a query to get start time and end time of each call from above 2 tables. Also create a column of call duration in minutes. 
-- Please do take into account that there will be multiple calls from one phone number and each entry in start table has a corresponding entry in end table.
-- (GOOD QUESTION)
-- CONCEPT - ROW_NUMBER() WINDOW FUNCTION
WITH start_cte AS 
(
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY phone_number ORDER BY start_time) AS rank
    FROM call_start_logs
),

end_cte AS
(
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY phone_number ORDER BY end_time) AS rank
    FROM call_end_logs
)
SELECT
    s.phone_number,
    s.start_time,
    e.end_time,
    DATEDIFF(MINUTE, s.start_time, e.end_time) AS call_duration
FROM start_cte s
INNER JOIN end_cte e
ON 
    s.phone_number = e.phone_number
    AND s.rank = e.rank
ORDER BY s.phone_number, s.start_time;

-- 6. https://www.namastesql.com/coding-problem/64-penultimate-order (GOOD QUESTION)
WITH order_rank AS
(
	SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY customer_name
						 ORDER BY order_date DESC, order_id DESC) AS rn,
		COUNT(*) OVER(PARTITION BY customer_name) AS order_count
	FROM orders
)

SELECT
	order_id,
	order_date,
	customer_name,
	product_name,
	sales
FROM order_rank
WHERE 
	(order_count = 1 AND rn = 1)
	OR (order_count > 1 AND rn = 2)
ORDER BY customer_name

-- 7. https://www.namastesql.com/coding-problem/26-dynamic-pricing (Slowly Changing Dimension SDC-Type2) (GOOD QUESTION)

WITH product_price_history AS 
(
	SELECT
		product_id,
		price,
		price_date AS start_date,
		LEAD(DATEADD(DAY, -1, price_date), 1, GETDATE()) OVER(
			PARTITION BY product_id
			ORDER BY price_date
		) AS end_date
	FROM products
)

SELECT
	ord.product_id,
	SUM(pph.price) AS total_sales
FROM orders ord
JOIN product_price_history pph
ON 
	ord.product_id = pph.product_id
	AND ord.order_date >= pph.start_date
	AND (
		ord.order_date <= pph.end_date
	)
GROUP BY ord.product_id
ORDER BY ord.product_id

-- 8. https://www.namastesql.com/coding-problem/125-project-budget (GOOD QUESTION)
WITH project_cost AS 
(
	SELECT
		p.id,
		p.title,
		p.budget,
		SUM(
			e.salary * DATEDIFF(DAY, p.start_date, p.end_date) / 365.0
		) AS forcast_cost
	FROM employees e
	INNER JOIN project_employees pe
	ON e.id = pe.employee_id
	INNER JOIN projects p
	ON pe.project_id = p.id
	GROUP BY 
		p.id,
		p.title,
		p.budget
	
)


select
	title,
	budget,
	CASE
		WHEN forcast_cost > budget THEN 'overbudget'
		ELSE 'within budget'
	END as label
FROM project_cost
ORDER BY title;

-- 9. write an sql to get top 3 customers by sales in each category for each quarter : example output:
-- category , quarter , customer , sales
-- Furniture, 2020-Q1, c1 , 1500
-- Furniture, 2020-Q1, c2 , 1200
-- Furniture, 2020-Q1, c3 , 1000

-- Furniture, 2020-Q2, c2 , 1300
-- Furniture, 2020-Q2, c4 , 1100
-- Furniture, 2020-Q2, c6 , 1000
WITH categoryQuartelySales AS
(
    SELECT
        category,
        CONCAT(YEAR(order_date), '-Q', DATEPART(QUARTER, order_date)) as yearQuarter,
        customer_id,
        SUM(sales) as sales
    FROM orders
    GROUP BY category, CONCAT(YEAR(order_date), '-Q', DATEPART(QUARTER, order_date)), customer_id
),

rankedCategoryQuartelySales AS 
(
    SELECT
        category,
        yearQuarter,
        customer_id,
        sales,
        DENSE_RANK() OVER(PARTITION BY category ORDER BY sales DESC) as rnk
    FROM categoryQuartelySales

)

SELECT
    category,
    yearQuarter,
    customer_id,
    sales
FROM rankedCategoryQuartelySales
WHERE rnk <= 3

-- 10 you have 2 tables where you have designation of each employee in 2020 and 2021
-- write a query to find the change in employee status . Expected output:
-- emp_id, comment
-- 1 , promoted 
-- 3 , promoted
-- 4 , resigned
-- 5 , new employee
-- Assume that there demotion policy is not there in the company. so an employee can either be promoted , resigned or new hire
WITH employeeDisgnationChanges AS
(
    SELECT
        COALESCE(t1.emp_id, t2.emp_id) AS emp_id,
        t1.designation AS designation2020,
        t2.designation As designation2021
    FROM emp_2020 t1
    FULL OUTER JOIN emp_2021 t2
    ON t1.emp_id = t2.emp_id
)

SELECT
    emp_id,
    CASE
        WHEN designation2020 IS NULL THEN 'new employee'
        WHEN designation2021 IS NULL THEN 'resigned'
        WHEN designation2020 <> designation2021 THEN 'promoted'
    END AS comment
FROM employeeDisgnationChanges
WHERE designation2020 IS NULL
    OR designation2021 IS NULL
    OR designation2020 <> designation2021;