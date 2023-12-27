-- /1393. Capital Gain/Loss
-- https://leetcode.com/problems/capital-gainloss/?envType=study-plan&id=sql-i

-- select stock_name, sum(if(operation = 'Buy',price, 0)) as total_buy, sum(if(operation = 'Sell', price , 0)) as total_sell 
-- from stocks
-- group by stock_name;

select stock_name, sum(if(operation = 'Sell', price , 0)) - sum(if(operation = 'Buy',price, 0)) as capital_gain_loss  
from stocks
group by stock_name;





-- /1407. Top Travellers
# select user_id, sum(distance) as travelled_distance  from rides
# group by user_id
# order by travelled_distance desc;

select u.name, if(sum(r.distance) is null ,0,sum(r.distance)) as travelled_distance
from users as u
left join rides as r
on u.id = r.user_id
group by r.user_id
order by travelled_distance desc, name;


-- /1158. Market Analysis I
select u.user_id as buyer_id, join_date, sum(case when year(order_date) = 2019 then 1 ELSE 0 END) as orders_in_2019
from Users u left join Orders o
on u.user_id = o.buyer_id
group by u.user_id
order by u.user_id






CREATE table employee (
	id serial primary key,
	name varchar(255) not null,
	department varchar(255) not null,
	salary int not null,
	phone int not null,
	UNIQUE (name,department),
	CHECK (salary > 10000),
	CHECK (phone > 1000000000)
);

select * from employee;


create table products (
	prodID int primary key,
	ProdName varchar(225) Not null,
	Qty int,
	description varchar(225),
	check (Qty>0)
);

create table orders(
	prodID int,
	OrderId serial primary key,
	Qty_sold int,
	check (Qty_sold > 0),
	constraint fk foreign key (prodID) references custm(prodID)
);




create table products (
	prodID int primary key,
	ProdName varchar(225) Not null,
	Qty int,
	description varchar(225),
	check (Qty>0)
);

create table Orders (
    prodID int,
    OrderId int primary key,
    Qty_sold int,
    check (Qty_sold > 0),
    price int,
    Order_date date,
    constraint fk foreign key (prodID) references products(prodID)

);