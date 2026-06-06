create table emp_index (
emp_id int,
emp_name varchar(10),
salary int
)

insert into emp_index
values (1,'Ankit',1000)
, (2,'Vikas',5000)
, (3,'Amit',2000)
, (4,'Rahul',7000)

select * from emp_index

create clustered index ix_emp_index_salary on  emp_index(salary)

create nonclustered index ix_emp_index_emp_id on  emp_index(emp_id)

1 , 122ne
2 , 363ff
3 , wgwhw
4 , 46egb

select * from emp_index where emp_id=3;



create table emp_index (
emp_id int primary key,
emp_name varchar(10),
salary int
)

insert into emp_index
values (3,'Ankit',1000)

insert into emp_index
values (1,'Vikas',5000)

select * from emp_index

select  row_number() over(order by a.row_id) as rn, a.* into orders_index 
from orders a, (select top 100 * from orders) b ;

select  order_id, order_date
from orders_index
where customer_id is not null

sp_helpindex orders_index
create clustered index ix_orders_customer_id on orders_index(customer_id)

create nonclustered index ix_orders_order_id on orders_index(order_id) include (order_date)

create nonclustered index ix_orders_order_id_customer_id on orders_index(customer_id,order_id)

customer_id , orderid
100 , 1
100, 2
100 , 3

where customer_id=1




select  order_id , order_date
from orders_index
where order_id='CA-2021-164098'

--orderid clustered
--customer id non clustred

select * 
from orders_index 
where order_id='CA-2021-147039' and customer_id='AA-10315'
---------------------------------------------------------
--------------------------------------------------------

--- where 
-- group by 
-- joins 

select -> faster 
--data loading is slow 
--drop index 
--insert the data
--create index 
-------------------------------

select * from employee

update employee
set salary =  salary * 1.1 
where dept_id in (select dep_id from dept where dep_name='Analytics')

select * from dept

--alter table employee add dept_name varchar(20)
select *
from employee
inner join dept on employee.dept_id=dept.dep_id


update employee
set dept_name =  dept.dep_name
from dept
where employee.dept_id=dept.dep_id

delete from employee
where dept_id not in (select dep_id from dept )

select * from employee
--------------------
--merge 
create table src_products (
id int,
price int
)

create table tgt_products (
id int,
price int
)

tgt_products
1, 40->50
2, 50



src_products
3,200
1,50

MERGE INTO tgt_products
USING src_products
ON tgt_products.id=src_products.id
WHEN MATCHED THEN
   UPDATE SET tgt_products.price = src_products.price
WHEN NOT MATCHED  THEN
   INSERT (id , price)
   VALUES (src_products.id,src_products.price);

   delete from src_products
 insert into src_products
 values (3,150),(4,250)

 select * from src_products;
 select * from tgt_products	 ;

 --assigments day 5
 create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');
INSERT INTO icc_world_cup values('WI','India','India');

write a query to produce below output from icc_world_cup table.
team_name, no_of_matches_played , no_of_wins , no_of_losses  
India, 2, 2, 0

with cte as (
select team_1 as team_name, COUNT(*) as no_of_matches 
, COUNT(case when team_1 = winner then winner else null end) as wins
from icc_world_cup
group by team_1
union all
select team_2 as team_name, COUNT(*) as no_of_matches 
, COUNT(case when team_2 = winner then winner else null end) as wins
from icc_world_cup
group by team_2
)
select team_name, sum(no_of_matches) as no_of_matches_played
, sum(wins) as total_wins, sum(no_of_matches)-sum(wins)  as no_of_losses, sum(wins) *2 as total_points
from cte
group by team_name;

with cte as (
select team_1 as team_name
, case when team_1 = winner then 1 else 0 end as win_flag
from icc_world_cup
union all
select team_2 as team_name
, case when team_2 = winner then 1 else 0 end as win_flag
from icc_world_cup
)
select team_name, count(*) as no_of_matches_played
, sum(win_flag) as total_wins, count(*)-sum(win_flag)  as no_of_losses, sum(win_flag)  *2 as total_points
from cte
group by team_name


---day 6 assignments
select * from emp_2020

select * from emp_2021

emp_id, comment
1 , promoted 
3 , promoted
4 , resigned
5 , new employee

select coalesce(e20.emp_id,e21.emp_id) as final_emp_id--,  e20.* , e21.*
, case when e20.designation!=e21.designation then 'promoted'
when e21.designation is null  then 'resigned'
else 'new employee'
end as comment
from emp_2020 e20
full outer join  emp_2021 e21 on e20.emp_id=e21.emp_id
where e20.designation!=e21.designation or e20.designation is null or e21.designation is null

emp1
id , salary, email_id
1, 5000 , abc@gmail.com
null , 6000 , abc1@gmail.com

emp2
id , salary
2 , 15000, abc1@gmail.com

emp3
id , salary , email_id

emp4
id , salary , email_id

emp1.email_id , coalesce(emp1.id , emp2.id,emp3.id,emp4.id , -1) 
from emp1
left join emp2 
left join emp3
left join emp4

select *, dense_rank() over(partition by dept_id order by salary desc , emp_age ) as rn
from employee






















