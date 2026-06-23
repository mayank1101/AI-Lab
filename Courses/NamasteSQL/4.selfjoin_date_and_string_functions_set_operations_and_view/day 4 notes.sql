--self join 
select * 
from orders o
inner join returns r on o.order_id=r.order_id

create table regional_manager
(
manager varchar(20),
region varchar(10)
)

insert into regional_manager
values ('Ankit','West')
,('Deepak','East')
,('Vishal','Central')
,('Sanjay','South')


select * from regional_manager

manager_name, total_return_sales

select rm.manager, SUM(o.sales) as total_return_sales 
from orders o
left join returns r on o.order_id=r.order_id
inner join regional_manager rm on o.region=rm.region
where r.return_reason is not null
group by rm.manager;

-------------------self join ----------------
--emp_id, emp_name , manager_name , manager_salary
--employees whose salary > manager salary 
select e.*, m.emp_name manager_name,m.salary as manager_salary
from employee e
inner join employee m on e.manager_id=m.emp_id 
where e.salary > m.salary;
-----------------------------------------------
select dept_id, AVG(salary) as avg_salary
from employee
group by dept_id;

select * from employee order by dept_id,salary
select dept_id , STRING_AGG(emp_name , ';') within group (order by salary) as emp_list
from employee
group by dept_id
;

select order_id , order_date , ship_date , sales
, DATEDIFF(month , order_date , ship_date) as date_diff
, DATEPART(YEAR,order_date) as year_order_date
, DATEPART(WEEKDAY,order_date) as weekday_order_date
, DATENAME(WEEKDAY,order_date) as weekday_order_date
, DATEADD(year,2,order_date)  as order_date_2
, quantity
, DATEADD(day,quantity,order_date)  as order_date_quanity
, GETDATE()
, YEAR(order_date) as year_order
, month(order_date) as year_order
from orders
where order_date < GETDATE()
--where DATEPART(YEAR,order_date)=2020
--where order_date between '2020-01-01' and '2020-12-31'
--string functions 
select order_id,customer_name, ship_mode 
,customer_id
,CONCAT(customer_id ,' ' ,customer_name, ' ', region) as customer
, upper(customer_name) as upper_cn
, LEN(customer_name) as len_customer_name
, LEFT(customer_name, 5) as customer_name_left5
, right(customer_name, 5) as customer_name_left5
, SUBSTRING(customer_name, 3 , 4) as substr34
, CHARINDEX(' ',customer_name) as space_position
, REVERSE(ship_mode) as r_sm
, REPLACE(ship_mode , 'C', 'M' ) as replace_ft
, TRANSLATE (ship_mode , 'ft','ab')
from orders
------------------------
--numeric and null handling functions 
select customer_name
, trim(SUBSTRING(customer_name,1, CHARindex(' ',customer_name) )) as first_name
from orders;
--------------------------------
--null handling 
select ISNULL(customer_id,'NA'),* from orders
select ISNULL(customer_id,customer_name),* from orders

--coalesce 
select coalesce(customer_id,customer_name,city,'NA'),* from orders
select coalesce(customer_id,customer_name),* from orders

update orders set customer_name = 'Sam Zeldin' where row_id=8285
-------------------------
--Sam Zeldin 
--cast function , numeric functions 
select
order_id, quantity, sales, profit
, ROUND(sales,1) as sales_1
, ROUND(sales,0) as sales_int
, floor(sales) as sales_f1
, CEILING(sales) as sales_c1
, ABS(profit) as abs_value
from orders
--------------------
--cast functions 
select order_id, profit , CAST(profit as int) as int_profit
,CAST(order_id as date)
from orders

create table dummy (id int)
insert into dummy values ('A')
select * from dummy;
------------------------------------
--set operations 
create table orders_west
(
order_id int,
region varchar(10),
sales int
);

create table orders_east
(
order_id int,
region varchar(10),
sales int
);
union , intersect 


insert into orders_west values(1,'west',100),(2,'west',200);
insert into orders_east values(3,'east',100),(4,'east',300);

select order_id as id, region, cast('2021-01-01' as date) as order_date from orders_west
union all
select order_id, region, 'Ankit' as mydate from orders_east
---number of columns should be same and data type for each column should be compatible

select order_id as id, sales from orders_west
union all
select sales, order_id from orders_east
---------------
insert into orders_west values(1,'west',100),(2,'west',200);
insert into orders_east values(3,'east',100),(4,'east',300);
--union
insert into orders_west values(1,'west',100)
insert into orders_east values(1,'west',100)

-- union removes duplicates, its a costly operation, working order of union -> (union all -> sorting -> removing distinct)
select * from orders_west
union
select * from orders_east

---union all
---sort 
--distinct
--intersect 
 1, 2 ,3
 3, 4 , 5
 union 1,2,3,4,5

select * from orders_west
intersect
select * from orders_east

--minus --except
select region from orders_west
except
select region  from orders_east

select region from orders_east
 except
select region  from orders_west

select * from orders_west
union 
select * from orders_west
union 
select * from orders_east

---------------------------
-- TABLE BACKUP
-- Get South region data into new Table orders_south
select *  into orders_south 
from orders
where region='South'

select * from orders_south


select *  into orders_backup
from orders

select * from orders_backup;
------------------------
-- database views
-- VIEW is DDL Command
-- View is encapsulation of Query
--normal
create view vw_orders_south as
select * 
from orders 
where region='South'

select * from vw_orders_south

insert into orders (row_id, region) values (-1,'South')
select * from orders

--materialized views
-- Here data will be stored in the view
-- faster than normal view because it doesn't run the query again and again it just returns the data
create materialized view mvw_orders_south as
select * 
from orders 
where region='South'

refresh view mvw_orders_south --  update materialized view data when any changes done to original data
--orders -> sunday ->
monday - friday
mvw_orders_south
refresh -< mv
-------------------------------

-- This will create temporary table only for current active session
select * into #temp_orders
from orders

--find duplicates 
select order_id , product_id, COUNT(*)
from orders
group by order_id, product_id
having COUNT(*)>1;
















































































