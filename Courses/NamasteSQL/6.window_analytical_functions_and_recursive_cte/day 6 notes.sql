--write a query to print emp name, salary and dep id of highest salaried employee in each department ;
USE analytics_bootcamp;


select top 1 * 
from employee
order by salary desc ;

--i want highest salary emp in each dept
with cte as (
select dept_id, MAX(salary) as max_salary
from employee
group by dept_id
)
select * 
from employee e
inner join cte on e.dept_id=cte.dept_id and salary =  max_salary
--where salary =  max_salary

with cte as (
select * 
, RANK() over(order by salary desc) as emp_rank
from employee
)
select * from cte 
where emp_rank<=3
---
select * 
, RANK() over(order by salary desc , emp_age ) as emp_rank
, DENSE_RANK() over(order by salary desc, emp_age) as emp_drank
, row_number() over(order by salary desc, emp_age) as emp_rn
from employee

select * 
, RANK() over(partition by dept_id order by salary desc) as emp_rank
, DENSE_RANK() over(partition by dept_id order by salary desc) as emp_drank
, row_number() over(partition by dept_id order by salary desc) as emp_rn
from employee;

--i want highest salary emp in each dept
with cte as (
select * 
, RANK() over(partition by dept_id order by salary desc) as emp_rank
, DENSE_RANK() over(partition by dept_id order by salary desc) as emp_drank
, row_number() over(partition by dept_id order by salary desc) as emp_rn
from employee
)
select * from cte 
where emp_rn <=2

select * 
from orders; 
--in each category give me top 5 products by sales (GOOD EXAMPLE)

with product_level_sale as (
select category , product_id , SUM(sales) as product_sales
from orders
group by category , product_id
)
, cte as (
select *
, RANK() over(partition by category order by product_sales desc) as rn
from product_level_sale
)
select *
from cte where rn<=5;
-----------------
select * 
, LEAD(salary , 1 ) over(order by salary desc) as next_salary
from employee

select * 
, LAG(salary , 1) over(order by salary) as next_salary
from employee;

-- compare employee salary dept wise with lowest salary
select *
, FIRST_VALUE(salary) over(partition by dept_id order by salary) as lowest_salary
from employee

-- compare employee salary dept wise with highest salary
-- Similar to first value we have LAST_VALUE function also
select *
, FIRST_VALUE(salary) over(partition by dept_id order by salary desc) as lowest_salary
from employee;
------------------------------------------------------------------------------------
----sub queries -----
---independent sub query--
--correlated sub query, these types of queries are very rarely used (very very less used)

-- DIFFERENCE BETWEEN Independent subquery and Correlated subquery
-- can be run independently, individualy, correlated-subquery can not run independently
-- it run ones only, correlated-subquery runs multiple times
select * 
from employee e1
where salary > (select AVG(salary) from employee e2 
where e1.dept_id=e2.dept_id and e1.emp_id!=e2.emp_id
);









select *
from employee e
inner join 
(select dept_id, AVG(salary) as avg_dept_salary
from employee
group by dept_id) d on e.dept_id=d.dept_id
where e.salary > d.avg_dept_salary;
-------------------------------------------------------
----recursive cte-----------
--running loop in sql 
-- very rarely used
with cte as (
select 1 as n --anchor row
union all
select n+1 as n from cte
where n < 500
)
select * 
from cte
option(maxrecursion 1000)

-- iteration 1-> n -> 1
-- iteration 2-> n -> 2
-- iteration 3-> n -> 3
-- iteration 4->
-- iteration 5->

---product table
create table products (
product_id int,
unit_price int,
effective_date date
)
insert into products
values 
(2 , 500 , '2024-11-10'),(2 , 900 , '2024-11-20')
(1 , 100 , '2024-10-01'),(1 , 200 , '2024-11-01')
select * from products ;


with cte as (
select * 
, LEAD(dateadd(day,-1,effective_date),1, GETDATE()) over(partition by product_id order by effective_date) as valid_till -- we subtrack one day so that there is no overlapping with next row date (i.e 2024-11-01)
from products
)
, rcte as 
(
select product_id,unit_price,effective_date,valid_till from cte  -- 1 100, 2024-10-01, 2024-10-31 - Anchor statement (starting point)
union all
select product_id,unit_price,dateadd(day,1,effective_date) as effective_date,valid_till -- we pick next date - 1, 100, 2024-10-02, 2024-10-31 
from rcte 
where dateadd(day,1,effective_date)<=valid_till -- check if next date 2024-10-02 <= 2024-10-31
)
select * from rcte
order by product_id,effective_date

-- 1, 100, 2024-10-01, 2024-10-31 - Anchor date (starting point)
-- 1, 100, 2024-10-02, 2024-10-31
-- 1, 100, 2024-10-03, 2024-10-3
-- ...........
-- 1, 100, 2024-10-31, 2024-10-31 (ends here)
-- 1, 200, 2024-11-01, 2024-11-30 (runs similary for this also....) 


select * 
, LEAD(salary , 1, salary) over(partition by dept_id order by salary) as next_salary
from employee


























--
