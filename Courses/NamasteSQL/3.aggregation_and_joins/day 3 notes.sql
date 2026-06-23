select * from customers;

update customers
set gender = 'F'
where customer_id in (1,4)


update customers
set gender = 'M'
where customer_id in (2,3)


update customers
set gender = 'M'
where gender = 'F'

select * from customers

create table  customers 
(
customer_id int,
gender varchar(1)
)

insert into customers values (1,'M') , (2,'F') , (3,'F') , (4,'M')


select * 
--, case when gender='M' then 'F' 
--else 'M' end as new_gender
from customers

update customers
set gender = case when gender='M' then 'F' else 'M' end;
---aggregation , start joins 

select region, SUM(sales) as regional_sales 
from orders
where category='Technology'
group by region
order by regional_sales  desc

select *, profit/sales as ratio
from orders
where category='Technology'
and ratio > 0
group by ratio
--from -> where -> group by -> select -> order by -> top
-------------------------------------------------
--aggregation 

select COUNT(*) as total_number_of_rows from orders
select sum(sales) as total_sales , MAX(sales) as max_sales
, min(sales) as min_sales , AVG(sales) as avg_sales
from orders

select SUM(sales) as total_sales, COUNT(*) as total_rows
, AVG(sales) as avg_sales , SUM(sales) /COUNT(*) as avg_sales_v2
from orders

select COUNT(*) as total_number_of_rows
, COUNT(distinct order_id) as no_of_orders
, COUNT(distinct product_id) as no_of_products
, COUNT(distinct category) as no_of_category
from orders

select COUNT(*) as total_number_of_rows
, COUNT(order_id) as total_rows
, COUNT(customer_id) as total_customer_rows
, COUNT('Ankit') as total_orders
from orders

select * from orders

order_id , sales
1 , 200
2, null
3, 100

select AVG(sales) from orders

300/2->150

------------------------------
select SUM(sales)
from orders 
where category='Furniture'

select top 10 customer_id, SUM(sales) as category_sales 
from orders 
group by customer_id
order by category_sales ;

select  category, sub_category 
, SUM(sales) as total_sales
from orders 
group by category, sub_category
order by category, sub_category


select  category, max(sub_category)  as max_sub_category
, SUM(sales) as total_sales
from orders 
group by category

select  category 
, SUM(sales) as total_sales
from orders 
group by category, sub_category
order by category

select   category , sub_category
, SUM(sales) as total_sales, SUM(profit) as total_profit, AVG(quantity)
from orders 
group by category, sub_category
order by category, sub_category
--- where 

select   sub_category
, SUM(sales) as total_sales, SUM(profit) as total_profit
from orders 
group by  sub_category
having SUM(sales)>50000
order by  total_sales

category, order_date , sales
technology , 2022-01-01, 100
technology , 2022-10-01, 200
furniture , 2022-11-01, 200
furniture , 2023-10-01, 300

select category , SUM(sales) as total_sales, MAX(order_date) as max_order_date
from orders
group by category
having MAX(order_date)  > '2020-04-01'

technology , 300 , 2022-10-01
furniture , 500 , 2023-10-01


select category , SUM(sales) as total_sales , MAX(order_date) as max_order_date
from orders
group by category
technology , 300 , 2022-10-01
furniture , 500 , 2023-10-01

select * 
from INFORMATION_SCHEMA.TABLES
where TABLE_NAME='orders'

select COUNT(distinct order_date), COUNT(distinct order_id) from orders
select * from orders


furniture 500

furniture 300


select * 
from orders
where SUM(sales)

--from -> where -> group by ->having-> select -> order by -> top
---------------------------------------------------------
--joins 

select r.return_reason,SUM(o.sales) as return_sales
from orders o
inner join returns r on r.order_id=o.order_id
group by return_reason

select r.return_reason,r.order_id, o.*
from orders o
left join returns r on r.order_id=o.order_id
--give me all the orders which were not returned 

select r.return_reason,r.order_id, o.*
from orders o
left join returns r on r.order_id=o.order_id
where r.order_id  is null


select r.return_reason,r.order_id, o.*
from orders o
left join returns r on r.order_id=o.order_id
where r.return_reason is not null


select r.return_reason,SUM(o.sales) as sales
from orders o
left join returns r on r.order_id=o.order_id
group by return_reason

--from -> inner join - > where -> group by ->having-> select -> order by -> top

select r.return_reason,SUM(o.sales) as sales 
from orders o
left join returns r on r.order_id=o.order_id
--where return_reason='Bad Quality'
group by return_reason;


select * 
from employee e
left join dept d on e.dept_id=d.dep_id
--right

select * 
from employee e
right join dept d on e.dept_id=d.dep_id

select * 
from dept d
left join employee e on e.dept_id=d.dep_id

select * 
from dept d
full outer join employee e on e.dept_id=d.dep_id

select *
from employee
cross join dept
order by emp_id

select *
from employee
inner join dept on 1=1
order by emp_id



select * from employee
select * from dept

select * 
from employee e
inner join dept d on e.dept_id=d.dep_id

--joining in where clause
select * 
from employee e, dept d 
where e.dept_id=d.dep_id


select  category , sub_category
, SUM(sales) as total_sales, SUM(profit) as total_profit, AVG(quantity)
from orders 
group by category, sub_category
having SUM(sales)>50000 and SUM(profit)>0
order by category, sub_category

---first thing tomorrow 3 table joins 
















