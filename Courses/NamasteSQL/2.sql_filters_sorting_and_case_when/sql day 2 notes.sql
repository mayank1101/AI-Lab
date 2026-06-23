--default constraint

drop table amazon_orders
create table amazon_orders
(
order_id int,
order_date date,
payment_method varchar(10) default 'UPI',
amount int
)
int, varchar, date, decimal, datetime
select * from amazon_orders
insert into amazon_orders values (1,'2024-01-01', default)
insert into amazon_orders values (2,'2024-01-01', 'CreditCard')

insert into amazon_orders values (4,'2024-01-02', 'UPI' , 100)

insert into amazon_orders values (5,'2024-01-02 09:12:30', 'UPI' , 100)

insert into amazon_orders(amount,order_id) values (100,3)
alter table amazon_orders alter column order_date datetime

select * from amazon_orders
delete from amazon_orders --where order_id=3
--database logging
truncate table amazon_orders  ;
-----------------------------------------------------------
select order_id, order_date 
from orders

select top 100 order_id , ship_mode
from orders

select * 
from orders
order by order_date  , row_id asc

/* order_id desc , payment_mode desc
10,
9, UPI
9, credit card
8,
7,*/
select * 
from orders
order by order_date desc, ship_date , order_id, product_name

select distinct category,sub_category
from orders
order by category,sub_category

select top 10 * 
from orders
order by order_date desc

-- from --> select --> order by --> top 
select *
from orders
--where category='Furniture'
where category in ('Furniture','Technology')

-- from --> where -> select -> distinct --> order by --> top 
select *
from orders
where 
--category!='Furniture'
category not in ('Furniture','Technology');

select order_id,order_date, quantity , profit
from orders
--where quantity != 2
--where quantity in (2,3,4)
--where quantity not between 2 and 8
where profit < 0
order by quantity

--2,3,4,5,6,7,8

select order_id,order_date, quantity , profit
from orders
--where order_date = '2019-06-18'
--where quantity in (2,3,4)
where order_date  between   '2019-06-01' and '2019-06-30'
--where profit < 0
order by order_date;


select *
from orders 
where category='Furniture' and region='East'

select order_id,order_date,category,region
from orders 
where category='Furniture' or region='East'

select order_id,order_date,category,region, quantity
from orders 
where category='Furniture' and quantity=2 and order_date = '2020-12-23'

select top 10 order_id,order_date,category,region, quantity
from orders 
where category='Furniture' and (quantity=2 or order_date = '2020-12-23')
order by quantity;

select * 
from orders
where customer_id is null and quantity=8

select * 
from orders
order by customer_id 

 null=null
null -> infinity 
update orders set customer_id=null where row_id in (8285,8290)


select order_id,customer_name
from orders
--where customer_name like '% Connell'
--where customer_name like 'B%r'
--where customer_name like '__e%'
where customer_name like '[AB]%' 
--where customer_name like '[^A-G]%'
--where customer_name not like 'B%r'
/*
%-> 0 or more characters anything can come
_ -> exactly one character
[] -> anyone character
^ negate the [] wild card search
*/
----------------------
select order_id, profit/sales * 100 as profit_sales_ratio
,order_date
, sales-profit as purchase_price
from orders;

--case when 

select order_id, order_date , profit
,case  
when profit< 0 then 'loss'
when profit<50 then 'low profit'
when profit<100  then 'high profit'
else 'very high profit'
end as profit_bucket
from orders
where case  
when profit< 0 then 'loss'
when profit<50 then 'low profit'
when profit<100  then 'high profit'
else 'very high profit'
end = 'loss'

;

select order_id, order_date , profit
,case  
when profit<0 then 'loss'
when profit>=0 and profit<50 then 'low profit'
when profit>=50 and profit<100  then 'high profit'
else 'very high profit'
end as profit_bucket
from orders
--> profit < 0 -> loss , profit < 50 then low profit , <100 high profit, >100 -> very high profit

select * 
from orders
where customer_name like  '[A-D]%'

select * from orders

alter table orders add profit_category varchar(20)
update orders 
set profit_category=case when profit<0 then 'loss'
when profit>=0 and profit<50 then 'low profit'
when profit>=50 and profit<100  then 'high profit'
else 'very high profit'
end














































