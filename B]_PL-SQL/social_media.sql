-- * Mastek Intern Notes: https://notepad.pw/oraclesql_jan24





--customers		
--	cid	    customername
--	c1001	Amit Jha 
--	c1002	Amit Kumar
--	c1003	Sumit Shah

--products
-- PRIMARY KEY (pid) 
--	pid	    productname	    unitprice
--	p1001	Butter	        10
--	p1002	Bread	        40
--	p1003	Jam	            20
--	p1004	Maggie	        20
--	p1005	Sugar 1 Kg	    45
--	p1006	Rice 1 Kg	    100

--orders
-- 



-- product table 
CREATE TABLE products(
    pid VARCHAR2(5) PRIMARY KEY,
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
DROP TABLE products;


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



-- customer.cust_id (1-N) orders.cust_id

-- orders table
DROP TABLE orders;

CREATE TABLE orders(
    order_id VARCHAR2(5) PRIMARY KEY,
    customer_id VARCHAR2(5),
    order_date DATE NOT NULL,
    
    -- cust_id VARCHAR2(5) NOT NULL,
    -- order_date DATE NOT NULL,
    -- order_amount NUMERIC(7, 2) NOT NULL,
    -- FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);