-- Link: https://www.oracletutorial.com/oracle-analytic-functions
-- Vdo: https://www.youtube.com/playlist?list=PLdnPqkBptCEITvVQtcOmKUgA7xT6Fqixc

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

-- LEAD: return the value of the next row
SELECT ename, sal, dept,
    LEAD(ename, 2, 'over loaded') OVER (ORDER BY sal) as next_sal
FROM emp;

-- LAG: return the value of the previous row

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
    ) * 100,2) || '%' percent_rank
FROM emp;

-- DENSE_RANK: return the rank of a value in a group
SELECT ename, sal, dept,
    DENSE_RANK() OVER (
        ORDER BY sal DESC
    ) as dense_rank
FROM emp;




-- NTH_VALUE: return the value of the nth row in a group
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

SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY dept
        ORDER BY sal DESC
    ) as row_number
FROM emp;


    SELECT *
    FROM (
        SELECT *, ROW_NUMBER() OVER (PARTITION BY group_column ORDER BY sort_column) AS row_num
    FROM your_table
    ) AS subquery
    WHERE row_num = 1;



SELECT *
FROM (SELECT *,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS row_num
    FROM Delivery)
WHERE row_num = 1;