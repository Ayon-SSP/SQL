-- Link: https://www.oracletutorial.com/oracle-analytic-functions
-- Vdo: https://www.youtube.com/playlist?list=PLdnPqkBptCEITvVQtcOmKUgA7xT6Fqixc


/*
-- Analytical Functions
Analytical functions in Oracle SQL are a set of powerful tools used for performing complex calculations 
across a set of rows returned by a query. They allow you to compute aggregated values such as moving 
averages, cumulative sums, rankings, and other statistical calculations without needing to use subqueries 
or self-joins.

1. Operate on a group of rows
2. Compute values based on order
3. Do not affect result set
4. Commonly used for reporting and analysis


*/

-- RANK() OVER() - return the rank of a value in a group(rank skipps) - 1, 2, 2, 4, 5
-- DENSE_RANK() - return the rank of a value in a group (no skipps) - 1, 2, 2, 3, 4
-- PERCENT_RANK() OVER () - return the percentile rank of a value in a group
-- CUME_DIST() OVER () - return the cumulative distribution of a value in a group
-- ROW_NUMBER() OVER () - return the sequential number of a row within a group
-- NTILE() OVER () - divide the rows in a group into n buckets
-- FIRST_VALUE() OVER () - return the first value in a group
-- LAST_VALUE() OVER () - return the last value in a group
-- LEAD() OVER () - return the value of the next row
-- LAG() OVER () - return the value of the previous row
-- PERCENTILE_CONT() OVER () - return the value at the specified percentile
-- PERCENTILE_DISC() OVER () - return the value at the specified percentile
-- NTH_VALUE() OVER () - return the value of the nth row in a group
-- AVG() OVER () - return the average of a set of values
-- SUM() OVER () - return the sum of a set of values
-- MAX() OVER () - return the maximum value in a set of values
-- MIN() OVER () - return the minimum value in a set of values





-- CUME_DIST 0 < ret<= 1
-- CUME_DIST() - non parameters funk
-- CUME_DIST() = (R) / N
CUME_DIST() OVER (
    [ query_partition_clause ] 
    order_by_clause
)

-- partition by type: total no. of rows 12 1's ROW1/(first partion set) -> 0.083
--      it will take the col no. / total no. of block rows
--      if found the same that take the last one


select * from emp;

select empno, ename, sal,   
    CUME_DIST() OVER (ORDER BY sal) as cume_dist
from emp;

-- add new column which dept in emp table
alter table emp add dept varchar2(20);
-- add data

-- give data to dept col with randow dept like 'Tech_ERP', 'AD', 'HCM'
update emp set dept = 'Tech_ERP' where empno in (7369, 7499, 7521, 7566, 7698, 7782, 7839);
update emp set dept = 'AD' where empno in (7902, 7876, 7788, 7934);
update emp set dept = 'HCM' where empno in (7654, 7844, 7900, 7901);
    
select dept, sal, 
    ROUND(CUME_DIST() OVER (PARTITION BY dept ORDER BY sal), 3) * 100 || '%' as cume_dist
from emp;


-- PERCENT_RANK() - same as CUME_DIST() but it will start from 0
-- PERCENT_RANK() = (R - 1) / (N - 1)

-- FIRST_VALUE: return the first value in the group
SELECT * FROM emp;

SELECT ename, sal, dept,
    FIRST_VALUE(sal) OVER (PARTITION BY dept ORDER BY sal) as first_sal
FROM emp;

-- LAST_VALUE: return the last value in the group
SELECT ename, sal, dept,
    LAST_Value(sal) OVER (
            PARTITION BY dept
            ORDER BY sal
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) as last_value
FROM emp;

-- LEAD: return the value of the next row(larger group will in the top)
SELECT ename, sal, dept,
    LEAD(ename, 2, 'over loaded') OVER (ORDER BY sal) as next_sal
FROM emp;

-- LAG: return the value of the previous row

-- NTILE: divide the rows in a group into n buckets: https://www.oracletutorial.com/oracle-analytic-functions/oracle-ntile/
SELECT ename, sal, dept,
    NTILE(4) OVER (PARTITION BY dept ORDER BY sal) as quartile
FROM emp;


-- PERCENTILE_CONT: return the value at the specified percentile

SELECT ename, sal, dept,
    PERCENTILE_CONT(0.5) -- 0 MEANS O PERSENTILE 1 100 PERSENTILE HIGEST0.5 MEANS IT WILL RETURN THE 50 PERCENTILE  
        WITHIN GROUP (ORDER BY sal) 
        OVER (PARTITION BY dept) as median_sal
FROM emp;

-- PERCENTILE_DISC: return the value at the specified percentile: SAME AS PERCENTILE_CONT BUT IT WILL RETURN THE NEAREST VALUE OF THE ROW, INSTED OF ACTUAL CUTOFF
SELECT ename, sal, dept,
    PERCENTILE_DISC(0.5) -- 
        WITHIN GROUP (ORDER BY sal) 
        OVER (PARTITION BY dept) as median_sal
FROM emp;

-- PERCENT_RANK: return the percentile rank of a value in a group
SELECT ename, sal, dept,
    ROUND(PERCENT_RANK() OVER (
        PARTITION BY dept
        ORDER BY sal
    ) * 100, 2) || '%' percent_rank
FROM emp;

-- DENSE_RANK: return the rank of a value in a group
SELECT ename, sal, dept,
    DENSE_RANK() OVER (
        ORDER BY sal DESC
    ) as dense_rank
FROM emp;




-- NTH_VALUE: return the value of the nth row in a group
-- NTH_VALUE returns NULL if there aren't enough rows in the window to reach the specified n.
-- n: The position of the desired row (1st, 2nd, 3rd...). It must be a positive integer.
SELECT
    product_id,
    product_name,
    list_price,
    NTH_VALUE(product_name,2) OVER (
        ORDER BY list_price DESC
        RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING
    ) AS second_most_expensive_product
FROM
    products;

-- ROW_NUMBER: return the sequential number of a row within a group
-- ROW_NUMBER() OVER (PARTITION BY partition_column(s) ORDER BY order_column(s))
SELECT * FROM emp;

SELECT *,  -- this is eg we can use * like this
    ROW_NUMBER() OVER (
        PARTITION BY dept
        ORDER BY sal DESC
    ) as row_num
FROM emp;

-- ranking in indusivial groups
SELECT *
FROM (
    SELECT product_id, year, quantity, price,
        ROW_NUMBER() OVER (PARTITION BY year ORDER BY year) AS group_rank
    FROM sales
) AS ranked_sales
WHERE group_rank = 1;

-- AVG(), SUM(), MAX(), MIN()
/*
student_name | score | class
-------------|-------|------
Alice        | 90    | A
Bob          | 85    | A
Charlie      | 80    | B
David        | 85    | B

SELECT 
    student_name,
    score,
    AVG(score) OVER () AS overall_average,
    AVG(score) OVER (PARTITION BY class) AS class_average
FROM 
    student_scores;

student_name | score | overall_average | class_average
-------------|-------|-----------------|--------------
Alice        | 90    | 85              | 87.5
Bob          | 85    | 85              | 87.5
Charlie      | 80    | 85              | 82.5
David        | 85    | 85              | 82.5
*/







-- Examples:
CREATE TABLE sales_data (
    sales_rep VARCHAR2(50),
    quarter VARCHAR2(10),
    sales_amount NUMBER
);

INSERT INTO sales_data (sales_rep, quarter, sales_amount)
VALUES ('John', 'Q1', 5000);

INSERT INTO sales_data (sales_rep, quarter, sales_amount)
VALUES ('Alice', 'Q1', 6000);

INSERT INTO sales_data (sales_rep, quarter, sales_amount)
VALUES ('Bob', 'Q1', 4500);


INSERT INTO sales_data (sales_rep, quarter, sales_amount)
VALUES ('John', 'Q2', 7000);

INSERT INTO sales_data (sales_rep, quarter, sales_amount)
VALUES ('Alice', 'Q2', 5500);

INSERT INTO sales_data (sales_rep, quarter, sales_amount)
VALUES ('Bob', 'Q2', 4800);

INSERT INTO sales_data (sales_rep, quarter, sales_amount)
VALUES ('John', 'Q3', 6200);

INSERT INTO sales_data (sales_rep, quarter, sales_amount)
VALUES ('Alice', 'Q3', 4800);

INSERT INTO sales_data (sales_rep, quarter, sales_amount)
VALUES ('Bob', 'Q3', 5100);

INSERT INTO sales_data (sales_rep, quarter, sales_amount)
VALUES ('John', 'Q4', 5500);

INSERT INTO sales_data (sales_rep, quarter, sales_amount)
VALUES ('Alice', 'Q4', 7200);

INSERT INTO sales_data (sales_rep, quarter, sales_amount)
VALUES ('Bob', 'Q4', 6000);

select * from sales_data;



--Q1. You want to categories your sales representative into different performance groups e.g. top_performer,average,dnm) based on their quarterly sales amount

SELECT 
    sales_rep,
    quarter,
    sales_amount,
    NTILE(3) OVER (PARTITION BY quarter ORDER BY sales_amount DESC) AS performance_group
FROM
    sales_data
ORDER BY quarter, performance_group;

-- Q2. Assign a sequential row number to each quarter record
SELECT 
    sales_rep,
    quarter,
    sales_amount,
    ROW_NUMBER() OVER (PARTITION BY quarter ORDER BY sales_amount DESC) AS row_num
FROM
    sales_data
ORDER BY quarter, row_num;

-- Q3. Rank Sales representative based on their sales amount within each quarter with gaps
SELECT 
    sales_rep,
    quarter,
    sales_amount,
    RANK() OVER (PARTITION BY quarter ORDER BY sales_amount DESC) AS rank
FROM
    sales_data
ORDER BY quarter, rank;

-- Q4. Rank Sales representative based on their sales amount within each quarter without gaps
SELECT 
    sales_rep,
    quarter,
    sales_amount,
    DENSE_RANK() OVER (PARTITION BY quarter ORDER BY sales_amount DESC) AS rank
FROM
    sales_data
ORDER BY quarter, rank;
-- Q5. Compare the sales amount of sales representative with the next quarters
SELECT 
    sales_rep,
    quarter,
    sales_amount,
    LEAD(sales_amount, 1, 0) OVER (PARTITION BY sales_rep ORDER BY quarter) AS next_quarter_sales
FROM
    sales_data
ORDER BY sales_rep, quarter;
