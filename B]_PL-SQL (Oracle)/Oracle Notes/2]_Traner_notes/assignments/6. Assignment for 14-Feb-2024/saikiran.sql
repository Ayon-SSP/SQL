                                                                 FEB 14 ASSIGNMENT 

--Using Grouping Additional Functions: Grouping sets, grouping, Grouping_Id, cube, rolup, pivot, unpivote 

--Calculate the total sales amount for each employee along with 
--a flag indicating if the employee has more than 50 orders 


select e.employeeid ,count(o.orderid) as total_orders,
round(sum(od.quantity* od.unitprice),2) as total_sales,
    case 
     when count(o.orderid)>50 then 'MORE THAN 50 ORDERS'
     when count(o.orderid)<50 then 'LESS THAN 50 ORDERS'
     else '50'
    end as Orders_more_than50
from employees e
 join orders o on e.employeeid = o.employeeid
 join orderdetails od on o.orderid = od.orderid
group by
grouping sets(
        (e.employeeid));


--Calculate the total number of orders and 
--total sales amount for each customer who 
--has placed orders in 1997

select c.customerid ,
count(distinct o.orderid)as order_count ,
round(sum(od.quantity* od.unitprice),2) as total_sales
from customers c 
    join orders o on c.customerid=o.customerid
    join orderdetails od on o.orderid=od.orderid
    where 
    extract(year from o.orderdate) =1997
group by 
grouping sets( (c.customerid));

--Count the number of orders for each product category, 
--and include a summary row showing the total
--number of orders for all categories

select * from categories ;
select c.categoryname ,
count(od.orderid) as totalorders 
from 
categories  c
join products p on p.categoryid = c.categoryid
join orderdetails od on p.productid =od.productid
group by
grouping sets(
            (c.categoryname),()
            );


--Calculate the total sales amount for each product category, 
--and indicate if the total sales amount is greater than $1000



select c.categoryname ,
sum(od.quantity * od.unitprice),
case
   when sum(od.quantity * od.unitprice) >1000 then 'YES'
   else 'NO'
   end as sales_greater_than1000
from categories c 
join  products p on p.categoryid =c.categoryid 
join orderdetails  od on od.productid = p.productid
group by 
grouping sets ((c.categoryname));


select * from customers;
--5)Calculate the average order value for each 
--customer, and include a summary row 
--for the overall average order value: 
select c.customerid,
 round((sum(od.unitprice* od.quantity)/count(distinct o.orderid)),10)as AVERAGE
 from customers c
    join orders o on o.customerid= c.customerid
    join orderdetails od on o.orderid =od.orderid
 group by
 grouping sets(
        (c.customerid)) 
        order by c.customerid;
        
    
--6 Calculate the total sales amount for each employee 
--along with subtotals by country and a grand total  
    select * from employees; 
     select e.employeeid , c.country,
     sum(od.unitprice*od.quantity) as total_sales
     from employees e
     join orders o  on e.employeeid=o.employeeid
     join orderdetails od on od.orderid=o.orderid
     join customers c on o.customerid= c.customerid
     group by 
     rollup( e.employeeid , c.country)
  ;
     
     
   --7)Count the total number of orders 
   --for each product category,
  -- subtotaled by year, and provide a grand total:   
  select  ca.categoryname , 
   extract(year from o.orderdate) as order_year,
   count(o.orderid)as total_sales
   from categories ca
   join products p on ca.categoryid = p.categoryid
   join orderdetails od on od.productid=p.productid
   join orders o on o.orderid= od.orderid
   
   group by
   rollup(ca.categoryname ,
   extract(year from o.orderdate))
   order by ca.categoryname;
   
  --8)Calculate the total sales amount 
  --for each shipper, subtotaled by region, 
  --and a grand total 
  
  select s.companyname ,o.shipregion as region ,
  sum(od.unitprice* od.quantity) as total_sales_amount
  from shippers s
  join orders o on o.shipvia=s.shipperid
  join orderdetails od on o.orderid=od.orderid
  group by 
  rollup(s.companyname ,o.shipregion);
  
  
--9 Count the total number of orders for each customer,
--subtotaled by month, and provide a grand total 
    select * from orders;
    select  c.customerid , 
  extract( month from  o.orderdate) as ordermonth,
    count( o.orderid)
    from customers c
     inner join orders o on o.customerid= c.customerid
     group by 
     rollup(c.customerid , 
    extract(month from o.orderdate)) 
    order by extract(month from o.orderdate) ; 
    
--10)Calculate the total sales amount 
--for each product, subtotaled by country,
--and provide a grand total
       select p.productname  , o.shipcountry ,
       sum(od.quantity* od.unitprice) as total_sales
       from products p
       join orderdetails od  using(productid)
       join orders o  using (orderid)
       group by
       rollup( p.productname  , o.shipcountry );
       
--11)Calculate the total sales amount 
--for each product category and year   

select * from(
        select ca.categoryname,
        Extract(year from o.orderdate)as order_year,
        sum(od.unitprice*od.quantity)as sales 
        from categories ca
        join products p using (categoryid)
        join orderdetails od using (productid)
        join orders o using (orderid)
        group by
        ca.categoryname,
        Extract(year from o.orderdate)
        ) 
pivot(
    sum(sales)
    for order_year in ( 
                        1996 as "1996",
                        1997 as "1997",
                        1998 as "1998",
                        1999 as "1999",
                        2000 as "2000")
        )
        order by categoryname ;
         
         


--12 Calculate the total quantity sold 
--for each product category and month 
select * from products;

select * from(
        select ca.categoryname,
        sum(od.quantity) as qty_count,
         TO_CHAR(o.orderdate, 'Mon') AS order_month
        from categories ca 
        join products p using(categoryid)
        join orderdetails od using (productid)
        join orders o using(orderid)
        group by 
        ca.categoryname,  TO_CHAR(o.orderdate, 'Mon')
            )
pivot(
    sum(qty_count)
    for order_month in (
                        'Jan' as "jan",
                        'Feb' as "feb",
                        'Mar' as "mar",
                        'Apr' AS "Apr",
                        'May' AS "May",
                        'Jun' AS "Jun",
                        'Jul' AS "Jul",
                        'Aug' AS "Aug",
                        'Sep' AS "Sep",
                        'Oct' AS "Oct",
                        'Nov' AS "Nov",
                        'Dec' AS "Dec"
                        )
    )
    order by categoryname;

--13)Count the total number of 
--orders for each shipper and country

select * from(
            select  s.companyname ,o.shipcountry as country,
           count( o.orderid) as order_count
            from shippers s
            join orders o on s.shipperid=o.shipvia
            group by  s.companyname , o.shipcountry
            )
    pivot(
        count(order_count)
        for country in (
                        'USA' as "usa" ,
                        'Canada' as "Canada",
                        'UK' as "UK",
                        'Germany' as "Germany",
                        'France' as "france"
                        )
        );
        

--Calculate the total sales
--amount for each employee and year
  
  select * from(
  select e.employeeid,
  extract(year from o.orderdate) as o_date,
  sum(od.unitprice* od.quantity)as sales
    from employees e
    join orders o  on o.employeeid=e.employeeid
    join orderdetails od on od.orderid=o.orderid
     group by  e.employeeid,extract(year from o.orderdate)
     )
     pivot(
     sum(sales)
     for o_date in(
                    1996 as "1996",
                    1997 as "1997",
                    1998 as "1998",
                    1999 as "1999",
                    2000 as "2000"
                    )
     )
     order by employeeid;
    
    
  --  15)Count the total number of 
   -- orders for each customer and year 
    
    select * from (
        select  c.customerid ,
        count(o.orderid) as ordercount,
        extract (year from o.orderdate) as yyear
        from customers c
        join orders o on o.customerid=c.customerid
        group by c.customerid ,  extract (year from o.orderdate)
        
        )
        pivot(
        count(ordercount)
        for yyear in(
                    1996 as "1996",
                    1997 as "1997",
                    1998 as "1998",
                    1999 as "1999",
                    2000 as "2000"
                    )
        )
        order by customerid;
        commit;
    
