-- * Mastek Intern (ORACLE) Notes: https://notepad.pw/oraclesql_jan24

/*
+----------------+       +----------------+       +---------------+   
|   products     |       |   customers    |       |   orders      |   
+----------------+       +----------------+       +---------------+   
| prod_id (PK)   |       | cust_id (PK)   |       | order_id (PK) |   
| product_name   |       | cust_name      |       | order_date    |   
| unit_price     |       +----------------+       | cust_id (FK)  |   
+----------------+                                +---------------+   

                +-------------------+
                |   orderdetails    |
                +-------------------+
                | order_id (FK, PK) |
                | prod_id (FK, PK)  |
                | quantity          |
                +-------------------+


*/

--products
-- PRIMARY KEY (prod_id) 
--	prod_id	productname	    unitprice
--	p1001	Butter	        10
--	p1002	Bread	        40
--	p1003	Jam	            20
--	p1004	Maggie	        20
--	p1005	Sugar 1 Kg	    45
--	p1006	Rice 1 Kg	    100

--customers		
--	cust_id customername
--	c1001	Amit Jha 
--	c1002	Amit Kumar
--	c1003	Sumit Shah

--orders 		
--	oderid	orderdate	cust_id
--	o1001	12-Dec-23	c1001
--	o1002	15-Dec-23	c1001
--	o1003	12-Dec-23	c1002
--	o1004	15-Dec-23	c1002
--	o1005	12-Dec-23	c1003
--	o1006	15-Dec-23	c1003

--orderdetails			
--	orderid	prod_id	qunatity
--	o1001	p1001	1
--	o1001	p1002	1
--	o1002	p1003	1
--	o1002	p1004	1
--	o1003	p1001	1
--	o1003	p1002	1
--	o1004	p1003	1
--	o1004	p1004	1
--	o1005	p1001	1
--	o1005	p1002	1
--	o1006	p1003	1
--	o1006	p1004	1
--	o1006	p1005	1
--	o1007	p1006	1

-- product table 
DROP TABLE products;

CREATE TABLE products(
    prod_id VARCHAR2(5) PRIMARY KEY,
    product_name VARCHAR2(25) NOT NULL,
    unit_price NUMERIC(7, 2) NOT NULL
);

INSERT INTO products VALUES('p1001', 'Butter',10);
INSERT INTO products VALUES ('p1002', 'Bread', 40);
INSERT INTO products VALUES ('p1003','Jam', 20);
INSERT INTO products VALUES ('p1004', 'Maggie', 20);
INSERT INTO products VALUES ('p1005', 'Sugar 1 Kg',45);
INSERT INTO products VALUES ('p1006', 'Rice 1 Kg',100);

SELECT * FROM products;


-- customer table
DROP TABLE customers;

CREATE TABLE customers(
    cust_id VARCHAR2(5) PRIMARY KEY,
    cust_name VARCHAR(25) NOT NULL
);

INSERT INTO customers VALUES('c1001', 'Amit Jha');
INSERT INTO customers VALUES('c1002', 'Amit Kumar');
INSERT INTO customers VALUES('c1003', 'Sumit Sha');

SELECT * FROM customers;



-- orders table
DROP TABLE orders;

CREATE TABLE orders(
    order_id VARCHAR2(5) PRIMARY KEY,
    order_date DATE NOT NULL,
    cust_id VARCHAR2(5) REFERENCES customers(cust_id)
);

INSERT INTO orders VALUES('o1001', '12-Dec-23', 'c1001');
INSERT INTO orders VALUES('o1002', '15-Dec-23', 'c1001');
INSERT INTO orders VALUES('o1003', '12-Dec-23', 'c1002');
INSERT INTO orders VALUES('o1004', '15-Dec-23', 'c1002');
INSERT INTO orders VALUES('o1005', '12-Dec-23', 'c1003');
INSERT INTO orders VALUES('o1006', '15-Dec-23', 'c1003');

SELECT * FROM orders;


-- orderdetails table
-- customer.cust_id (1-N) orders.cust_id

DROP TABLE orderdetails;

CREATE TABLE orderdetails(
    order_id VARCHAR2(5) REFERENCES orders(order_id),
    prod_id VARCHAR2(5) REFERENCES products(prod_id),
    quantity NUMERIC(7, 2) NOT NULL,
    CONSTRAINT pk_orderdetails PRIMARY KEY (order_id, prod_id) -- composite primary key 
);

INSERT INTO orderdetails VALUES('o1001', 'p1001', 1);
INSERT INTO orderdetails VALUES('o1001', 'p1002', 1);
INSERT INTO orderdetails VALUES('o1002', 'p1003', 1);
INSERT INTO orderdetails VALUES('o1002', 'p1004', 1);
INSERT INTO orderdetails VALUES('o1003', 'p1001', 1);
INSERT INTO orderdetails VALUES('o1003', 'p1002', 1);
INSERT INTO orderdetails VALUES('o1004', 'p1003', 1);
INSERT INTO orderdetails VALUES('o1004', 'p1004', 1);
INSERT INTO orderdetails VALUES('o1005', 'p1001', 1);
INSERT INTO orderdetails VALUES('o1005', 'p1002', 1);
INSERT INTO orderdetails VALUES('o1006', 'p1003', 1);
INSERT INTO orderdetails VALUES('o1006', 'p1004', 1);
INSERT INTO orderdetails VALUES('o1006', 'p1005', 1);
-- INSERT INTO orderdetails VALUES('o1007', 'p1006', 1); -- not pk in order table;
-- INSERT INTO orderdetails VALUES('o1001', 'p1001', 1);

SELECT * FROM orderdetails;






-- CREATE TABLE orders(
--     order_id VARCHAR2(5) REFERENCES orders(order_id),
--     prod_id varchar2(5) REFERENCES products(prod_id),
--     customer_id VARCHAR2(5),
--     order_date DATE NOT NULL,

--     -- cust_id VARCHAR2(5) NOT NULL,
--     -- order_date DATE NOT NULL,
--     -- order_amount NUMERIC(7, 2) NOT NULL,
--     -- FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
-- );

/*
* for Primary and foreign KEYS
ON DELETE SET NULL
ON DELETE CASCADE
*/