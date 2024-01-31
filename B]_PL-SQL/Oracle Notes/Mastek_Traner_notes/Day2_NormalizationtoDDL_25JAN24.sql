-- create product table - DDL
create table products(
    pid varchar2(5) primary key,
    productname varchar(25) not null,
    unitPrice NUMERIC(7,2) not null
);
create table customers(
 cust_id varchar2(5) primary key,
 cust_name varchar(25) not null
);
create table orders(
order_id varchar2(5) primary key,
orderdate date not null,
cust_id varchar2(5) references  customers(cust_id) 
);
create table orderdetails(
order_id varchar2(5) references orders(order_id),
pid  varchar2(5) references products(pid),
quantity numeric(3) not null,
constraint pk_orderdetails primary key (order_id,pid)
)
