--4- write a query to find sub-categories where 
--average profit is more than the half of the max profit in that sub-category (validate the output using excel)

select sub_category, AVG(profit) as avg_profit, MAX(profit)/2 as max_profit_half
from orders 
group by sub_category
having AVG(profit)>MAX(profit)/2;

create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

--write a query to find students who have got same marks in Physics and Chemistry. ->1
select * from exams where subject in ('Chemistry','Physics')


select student_id,COUNT(*)
from exams
where subject in ('Chemistry','Physics')
group by student_id
having COUNT(*)=2 and COUNT(distinct marks)=1

select student_id,marks , COUNT(*) 
from exams
where subject in ('Chemistry','Physics')
group by student_id,marks
having COUNT(*)=2

--9- write a query to get region wise count of return orders

select region,count(distinct o.order_id) as no_of_return_orders
from orders o
inner join returns r on o.order_id=r.order_id
group by region

--10- write a query to get category wise sales of orders that were not returned
select *
from orders o
left join returns r on o.order_id=r.order_id
where r.order_id is null

--12- write a query to print dep names where none of the emplyees have same salary.

select dept_id, COUNT(*) as no_of_employee , COUNT(distinct salary) as distinct_salary
from employee
group by dept_id
having COUNT(*) = COUNT(distinct salary) ;

--13- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)

select  o.sub_category,COUNT(distinct r.return_reason)--, r.return_reason, COUNT(distinct o.order_id) as return_orders
from orders o
inner join returns r on o.order_id=r.order_id
group by  o.sub_category
having COUNT(distinct r.return_reason)=3;


--18- write a query to print 3 columns : category, total_sales and (total sales of returned orders)
select o.category , SUM(o.sales) as total_sales
, SUM(case when r.order_id is not null then o.sales else 0 end) as return_sales
--,o.sales, case when r.order_id is not null then o.sales end as return_sales , return_reason
from orders o
left join returns r on o.order_id=r.order_id
group by o.category

----day 4 assignments 
--4- write a query to get number of business days between order_date and ship_date (exclude weekends). 
--Assume that all order date and ship date are on weekdays only.
select order_id, order_date,ship_date
, DATEDIFF (DAY,order_date,ship_date) as no_of_days, DATEDIFF (week,order_date,ship_date) as no_of_weeks
, DATENAME(weekday,order_date)  as order_date_name, DATENAME(weekday,ship_date)  as ship_date_name
, DATEDIFF (DAY,order_date,ship_date) - 2*DATEDIFF (week,order_date,ship_date) as no_of_business_days
from orders ;
--friday -> tuesday

/*write a query to print below output using drivers table. Profit rides are the no of rides where end location and end_time of a ride is same as start location ans start time of the next ride for a driver
id, total_rides , profit_rides
dri_1,5,1
dri_2,2,0 */

select d1.id  , COUNT(*) as total_rides, COUNT(d2.id) as profit_rides
from drivers d1
left join drivers d2 on d1.id=d2.id and d1.end_loc=d2.start_loc and d1.end_time=d2.start_time
group by d1.id  ;

select * from drivers;
----------------------------------------------------------
--sub query
select AVG(sales) as avg_order_value
, SUM(sales)/COUNT(distinct order_id) as actual_avg
from orders
--229.858000830493
--458.61
--458.614665661807

select AVG(orderwise_sales) as aov from 
(select order_id , SUM(sales) as orderwise_sales
from orders
group by order_id
) a
---------------
-- Get me all those employees who salary is greater than their department's average salary
select *
from employee e
inner join 
(select dept_id, AVG(salary) as avg_dept_salary
from employee
group by dept_id) d on e.dept_id=d.dept_id
where e.salary > d.avg_dept_salary;

---i want all the orders whose total order value > average order value
select order_id , SUM(sales) as orderwise_sales
from orders
group by order_id
having SUM(sales) > (select AVG(orderwise_sales) as aov from 
(select order_id , SUM(sales) as orderwise_sales
from orders
group by order_id
) a
)

--from -> join -> having

-- all the employees who department is not present in department table
select * 
from employee
where dept_id not in (select dep_id from dept)

select * 
from employee
where dept_id not in (100,200,300,400)

-- get me department who has no employee
select * 
from dept
where dep_id not in (select dept_id from employee)

select *, (select AVG(salary) from employee) as avg_salary
from employee
where emp_id>5;

--cte -> common table expression 
-- we will use 80-90% of time sub-query/CTE 
-- order of execution is from top to bottom for CTE
-- CTE/sub-query executes first then normal SQL query execution order follows.
-- always start from CTE, if performance issue is there then go with tmp table.
with dep_avg as 
(select dept_id, AVG(salary) as avg_dept_salary
from employee
group by dept_id)
select *
from employee e
inner join 
dep_avg d on e.dept_id=d.dept_id
where e.salary > d.avg_dept_salary;
-------------------------
-- get me all the orders where order total_sales > avg sales of all orders
select order_id , SUM(sales) as orderwise_sales
from orders
group by order_id
having SUM(sales) > (select AVG(orderwise_sales) as aov from 
(select order_id , SUM(sales) as orderwise_sales
from orders
group by order_id
) a
)

with order_value as --this cte will get total sales at order id level
(
select order_id , SUM(sales) as orderwise_sales
from orders
group by order_id
)
select * 
from order_value
where orderwise_sales > (select AVG(orderwise_sales) as aov from 
--this filter will give me orders where total sales > average order sales
order_value
)
---temporary tables 
--this cte will get total sales at order id level
-- we can create index on tmp tables
-- time is reduced when using tmp tables because data is stored on the disk
-- tmp table created as 
-- create temporary table table_name as
-- (select order_id , SUM(sales) as orderwise_sales
-- from orders
-- group by order_id
-- )
select order_id , SUM(sales) as orderwise_sales into #order_value
from orders
group by order_id
select * from #order_value


select * 
from #order_value
where orderwise_sales > (select AVG(orderwise_sales) as aov from 
--this filter will give me orders where total sales > average order sales
#order_value
)

with order_value as --this cte will get total sales at order id level
(
select order_id , SUM(sales) as orderwise_sales
from orders
group by order_id
),
cte_aov as (select AVG(orderwise_sales) as aov from order_value)
select * 
from order_value
where orderwise_sales > (select aov from cte_aov)



cte1
cte2
cte3 
cte4
cte5
select 
from 
































































