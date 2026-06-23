--advanced aggregate functions , stored procedures 

select * from employee

--i want employees whose salary is greater than dept average salary

select *
from employee e
inner join (select  dept_id, AVG(salary) as avg_salary
from employee
group by dept_id) d on d.dept_id=e.dept_id
where salary > avg_salary


select * 
--, AVG(salary) over(partition by dept_id) as dept_avg_salary
--, sum(salary) over(partition by dept_id) as dept_total_salary
, sum(salary) over(partition by dept_id order by emp_age) as dep_running_salary
from employee

select * 
--, sum(salary) over(order by emp_id rows between 2 preceding and current row) as salry_current_previous
--, sum(salary) over(order by emp_id rows between current row and 1 following) as salry_current_previous
, sum(salary) over(order by emp_id rows between unbounded preceding and  current row) as salry_current_previous
--, sum(salary) over(partition by dept_id order by emp_id rows between unbounded preceding and  unbounded following) as salry_current_previous
from employee;
---find rolling 3 months sales for each month from orders data


with cte as (
select YEAR(order_date) as order_year, MONTH(order_date) as order_month , SUM(sales) as total_sales
from orders
group by YEAR(order_date),MONTH(order_date)
)
select *
--, SUM(total_sales) over(partition by category order by order_year, order_month rows between 3 preceding and 1 preceding) as rolling3
, SUM(total_sales) over(order by order_year, order_month rows between 2 preceding and current row) as rolling3
, SUM(total_sales) over(order by order_year, order_month rows between 2 preceding and current row) as rolling3
from cte ;


1 
2 , 1
3 , 3
4 , 6
5 , 9
select * 
, sum(salary) over(order by salary rows between unbounded preceding and  current row) as salry_current_previous
, sum(salary) over(order by salary) as salary_current_previous
from employee;

---query writing 
---stored procedures

--program in sql 
---application dev
----analytics 

---students 
--student id , email id , name , country ->sign up
--retirve the etails -> retieve details 
--modify profile  -> update profile
--course enrollment  -> 
create table students (
student_id int identity (1,1),
email_id varchar(20),
name varchar(20),
country varchar(20)
)
--action -> sighup , modify profile -> retirve 
--> post and get -> sign up , modify


create or alter procedure sp_manage_students (@action_type varchar(4),@email_id varchar(20),@name varchar(20),@country varchar(20) )
as
begin 
declare @is_exists int
if @action_type='get'
	select * from students where email_id=@email_id
else 
	select @is_exists = COUNT(*) from students where email_id=@email_id
	if @is_exists=0
		insert into students values (@email_id, @name, @country)
	else
		update students set name=@name, country=@country 
		where email_id=@email_id
		print 'Your profile has been updated'
end 

sp_manage_students 'post', 'ankit@gmail.com' ,'Ankit' ,'India'
sp_manage_students 'post', 'nachiket@gmail.com' ,'Nachiket' ,'Australia'
sp_manage_students 'post', 'virat@gmail.com' ,'VK' ,'UK'

sp_manage_students 'get', 'fgjf@gmail.com' ,null ,null

select * from students ;
select * from students ;



---- Functions in SQL
select *
, LEN(customer_name) as cust_len
, DATEPART(month,order_date) as order_month
,LEFT(customer_name,4) as left4
from orders

--busniess days between 2 dates
start_date and end_date
--user defined function

create or alter function fn_business_days (@start_date date  , @end_date date)
returns int
begin
return (select DATEDIFF(day,@start_date,@end_date) - 2* DATEDIFF(week,@start_date,@end_date))
end 

select dbo.fn_business_days(order_date,ship_date) as business_days
,*
from orders; 

-- PL-SQL used in Oracle
-- T-SQL used in SQL Server

select * 
,last_value(emp_id) over(order by emp_id rows between current row and unbounded following) as lv
from employee

functional -> build pipelines 
data engineers 

select customer_name from orders where upper(customer_name) like '[^A]%[^N]';

snowflake data engineer  
dbt coalesce 

update
--src  1 5
target 1
insert 
select 
* from source where emp_id not in (select emp_id from target)









