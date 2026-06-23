---DDL -> data definition language
---DML -> data manipulation language
---DQL -> data query laungaue

drop table amazon_orders;
create table amazon_orders
(
--order_id int unique,
--order_id int primary key,
order_id int,
order_date date not null,
product_name varchar(50),
customer_name varchar(20) REFERENCES customers(customer_name),
amount decimal(6,2) check (amount>0),
payment_method varchar(20) ,
quantity int
constraint pk_orders primary key (order_id, product_name)
);
DQL 
select * from customers
delete from customers
create table customers (customer_name varchar(20) primary key, city varchar(20))
insert into customers values ('Ankit', 'Bangalore')

insert into amazon_orders values (1, '2024-01-01', 'Baby Diaper' , 'Ankit Bansal' , 132.32, 'UPI', 2)
insert into amazon_orders values (1, '2024-01-01', 'phone' , 'Ankit Bansal' , 132.32, 'UPI')
insert into amazon_orders values (1, '2024-01-02', 'phone' , 'Ankit' , 132.32, 'UPI')
insert into amazon_orders(order_id, order_date) values (1, '2024-01-01', 'phone' , 'Ankit' , 5, 'UPI')
insert into amazon_orders values (1, '2024-01-01', 'phone' , 'Ankit' , 5, 'UPI')
select * from amazon_orders

insert into amazon_orders values (1, '2024-01-01', 'Baby Diaper' , 'Ankit Bansal' , 132.32, 'UPI', 2)

/*
create table customer (cust varchar(10))
select * from customer
insert into customer values (null)
*/

null
--constraints
--unique --no duplicate
-- not null-- values can not be null
-- primary key constraints -> no duplicates and no null
--check
--forein key constraint
--default
varchar(max) -> 65000

--ddl 

alter table amazon_orders alter column customer_name varchar(50)
alter table amazon_orders alter column customer_name int --error
alter table amazon_orders alter column order_date varchar(20)

alter table amazon_orders add category varchar(20)

alter table amazon_orders drop column payment_method

drop table amazon_orders

--null
--data query laungauge
select * from amazon_orders;

--dml
insert into amazon_orders values (1, '2023-07-25', 'Baby Diaper' , 'Ankit Bansal' , 132.32, 'UPI')
insert into amazon_orders values (2, '2023-07-26', 'iphone' , 'Rahul Bansal' , 6332.32, 'Credit card')

--dml
delete from amazon_orders where order_id=2

--dml
update amazon_orders
set category='new book' , amount=20 
where order_id=2
--where category='new book'

update amazon_orders
set amount=20
where order_id=2

--data types
--int 0, 1 ,2 3 , -1 , -2
--date 'YYYY-MM-DD'
--varchar(length) -- to store any string values
-- decimal
/*decimal(6,2)
123.23
1234.5
1234.543
*/
-- sql server -> databases -> create multiple schemas

create table sales.amazon_orders_sales
(
order_id int ,
order_date date,
product_name varchar(50),
customer_name varchar(20),
amount decimal(6,2),
payment_method varchar(20)
)

