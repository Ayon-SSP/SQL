

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










-- schema
create table products (
	prodID serial primary key,
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


alter table Orders
add column product_name varchar(225);

-- alter the table orders and add a column product_revue with a default value of 0 and check constraint of 0 to 10
alter table Orders
add column product_revue int default 0 check (product_revue >= 0 and product_revue <= 10);




-- change the constrans fo the product_revue to 0 to 10
alter table Orders
alter column product_revue int;




drop table Orders;
drop table products;



select * from orders;
truncate table orders;

select * from products;
truncate table products;






-- insert data in products table
insert into products (prodName, Qty, description) values ('laptop', 10, 'HP');

insert into orders (prodID, OrderId, Qty_sold, price, Order_date) values (1, 1, 5, 1000, '2020-01-01');

-- insert data in orders table
insert into orders (prodID, OrderId, Qty_sold, price, Order_date, product_revue, product_name) values (1, 1, 5, 1000, '2020-01-01', 5, 'laptop');



-- insert data in orders table
update orders
set product_name = 'laptop'
where prodID = 1;

-- update the product_revue to 5 and product_name to laptop
update orders
set product_revue = 5, product_name = 'laptop'
where prodID = 1;


















