-- https://youtu.be/N43ZNpB5j4Y?si=oiJXHb-8GL7uguw7

SELECT deptno, SUM(sal), AVG(sal), MAX(sal)
FROM emp
GROUP BY deptno;
-- O/P
-- DeptNo  sum(sal)  avg(sal)        max(sal)
-- 10      8750      2916.66666666   5000
-- 20      10875     2175            3000
-- 30      9400      1566.66666666   2850


SELECT deptno, SUM(sal), AVG(sal), MAX(sal)
FROM emp
GROUP BY ROLLUP(deptno);

-- O/P
-- DeptNo  sum(sal)  avg(sal)        max(sal)
-- 10      8750      2916.66666666   5000
-- 20      10875     2175            3000
-- 30      9400      1566.66666666   2850
-- NULL    29025     2175            5000 - max of all dept
--        sum of all depts   - avg of all avg's


SELECT deptno, SUM(sal), AVG(sal), MAX(sal)
FROM emp
GROUP BY CUBE(deptno);

-- -<or>-
-- cross tabulation data
SELECT deptno, SUM(sal), AVG(sal), MAX(sal)
FROM emp
GROUP BY GROUPING CUBE(deptno, job);

-- O/P
-- DeptNo Job  sum(sal)  avg(sal)        max(sal)
-- 10     CLERK  1300      1300            1300
-- 10     Manager 2450      2450            2450
-- 10     PRESIDENT 5000      5000            5000
-- 10     NULL  8750      2916.66666666   5000
-- 20     ANALYST  6000      3000            3000
-- 20     CLERK  1900      950             1300
-- ...

