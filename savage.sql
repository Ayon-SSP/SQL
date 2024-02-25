DECLARE
    TYPE emp_rec_type IS RECORD (
        deptno emp.deptno%TYPE,
        total_sal emp.sal%TYPE
    );
    
    TYPE emp_ref_cursor IS REF CURSOR 
    RETURN emp_rec_type;
    
    v_emp_cursor emp_ref_cursor;
    v_emp_rec emp_rec_type;
BEGIN
    OPEN v_emp_cursor FOR
        SELECT deptno, SUM(sal) AS total_sal
        FROM emp
        WHERE deptno IS NOT NULL
        GROUP BY deptno
        ORDER BY deptno;

    LOOP
        FETCH v_emp_cursor INTO v_emp_rec;
        EXIT WHEN v_emp_cursor%NOTFOUND;
        DBMS_OUTPUT.put_line('Department No: '|| v_emp_rec.deptno || ', Total Salary: ' || v_emp_rec.total_sal);
    END LOOP;

    CLOSE v_emp_cursor;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.put_line('No data found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/
--24 Write a PL/SQL block to fetch and display the details of  

--employees who work in the 'New York' branch.  

select * from branch; 

 

declare 

type rct is ref cursor; 

curr rct; 

recc emp.ename%type; 

 

begin 

open curr for  

    select e.ename  from emp e  

    join branch b using(branchno)  

    where b.location='NEW YORK'; 

loop 

fetch  curr into recc; 

exit when curr%notfound; 

dbms_output.put_line(recc); 

end loop; 

close curr; 

end; 

 

--25 Write a PL/SQL block to fetch and display the average  

--salary for employees in each branch.  

declare 

type rct is ref cursor ; 

cur rct; 

v_branch emp.branchno%type; 

avgsal number; 

begin 

open cur for select branchno, avg(sal) from emp group by branchno; 

loop 

fetch cur into v_branch,avgsal ; 

exit when cur%notfound; 

dbms_output.put_line(v_branch||'-'||avgsal); 

end loop; 

close cur; 

end; 

 

--26 Write a PL/SQL block to fetch and display the details of all  

--employees in department 10.  

declare  

  cur_emp  sys_refcursor; 

  rec_emp emp%rowtype; 

  begin 

  open cur_emp for select * from emp where deptno=10; 

  loop 

  fetch cur_emp into rec_emp ; 

  exit when cur_emp%notfound; 

  dbms_output.put_line(rec_emp.ename|| '-'||rec_emp.deptno); 

  end loop; 

  end; 

 

--27 Write a PL/SQL block to display the total salary expense for  

--each department.  

declare  

cur sys_refcursor; 

rec emp.deptno%type; 

totsal number; 

begin 

open cur for select distinct deptno from emp where deptno is not null; 

loop 

fetch cur into rec; 

exit when cur%notfound; 

select nvl(sum(sal),0) into totsal  from emp where  deptno =rec; 

dbms_output.put_line(totsal|| '-'||rec); 

end loop; 

end; 

--28 Write a PL/SQL block to fetch and display the details of  

--employees whose salary is greater than 5000.  

declare  

 

cur sys_refcursor; 

rec emp%rowtype; 

begin 

open cur for select * from emp where sal >5000; 

loop 

fetch cur into rec ; 

exit when cur%notfound; 

dbms_output.put_line(rec.ename|| '-'||rec.sal); 

end loop; 

close cur; 

end; 

 

 

--29 Write a PL/SQL block to fetch and display the details of  

--employees who work in the 'New York' branch.  

declare 

 

curr sys_refcursor; 

recc emp.ename%type; 

 

begin 

open curr for  

    select e.ename  from emp e  

    join branch b using(branchno)  

    where b.location='NEW YORK'; 

loop 

fetch  curr into recc; 

exit when curr%notfound; 

dbms_output.put_line(recc); 

end loop; 

close curr; 

end; 

--30 Write a PL/SQL block to fetch and display the average  

--salary for employees in each branch.  

declare 

cur sys_refcursor; 

v_branch emp.branchno%type; 

avgsal number; 

begin 

open cur for select branchno, avg(sal) from emp group by branchno; 

loop 

fetch cur into v_branch,avgsal ; 

exit when cur%notfound; 

dbms_output.put_line(v_branch||'-'||avgsal); 

end loop; 

close cur; 

end; 

 

--31 Write a PL/SQL procedure to calculate the total salary of all  

--employees in a given department. 

 

create or replace procedure p_avgsal_ofemp as 

 totsal emp.sal%type; 

 cursor c is select distinct deptno from emp where deptno is not null; 

begin 

  for rec in c  

  loop 

  select sum(sal) into totsal from emp where deptno =rec.deptno; 

  dbms_output.put_line(totsal); 

  end loop; 

end; 

 

begin 

  p_avgsal_ofemp; 

 end; 

--32 Write a PL/SQL procedure to find the average salary of  

--employees in each department and display the result.  

 

create or replace procedure p_avg_sal_of_emp_bydept as  

cursor c is select avg(sal) as avgg ,deptno from emp where deptno in(10,20,30) group by deptno; 

avgsal emp.sal%type; 

begin 

for rec in c 

 

loop 

dbms_output.put_line('in dept no '||rec.deptno||'average sal is ->'||round(rec.avgg,2)); 

end loop; 

end; 

 

begin 

P_AVG_SAL_OF_EMP_BYDEPT; 

end; 

--33 Write a PL/SQL procedure to update the salary of an  

--employee by a given percentage.  

create or replace procedure p_emp_updation_ofsal 

as 

cursor c is select * from emp; 

begin 

 for rec in c 

 loop 

  update emp set sal =sal*10 where empno= rec.empno; 

  dbms_output.put_line(rec.ename ||' -' ||rec.sal); 

  end loop; 

end; 

 

begin 

P_EMP_UPDATION_OFSAL; 

end; 

select * from emp; 

--34 Write a PL/SQL procedure to delete all employees in a given  

--department.  

create or replace procedure p_delect_from_emp 

as  

cursor c is select * from emp; 

begin 

for rec in c  

loop 

delete from emp where empno= rec.empno; 

end loop; 

dbms_output.put_line('table deleted'); 

end; 

begin 

p_delect_from_emp; 

end; 

 

--35 Write a PL/SQL procedure to display the details of all  

--employees in a given branch. 

select * from branch; 

select * from emp; 

create or replace procedure p_emp_by_branch as 

cursor c is select e.ename , b.branchname  

from emp e join branch b using (branchno);  

begin 

for rec in c 

loop 

dbms_output.put_line( rec.ename ||' belongs to '||rec.branchname); 

end loop; 

 

end; 

 

begin 

p_emp_by_branch; 

end; 

 

--36 Write a PL/SQL function to calculate the total salary of  

--employees in a given department.  

 

 

create or replace function fun_totsa_ofemp(p_deptno in number) 

return number 

is 

totsal number; 

begin 

select sum(sal)into totsal from emp where deptno =p_deptno; 

dbms_output.put_line('for deptno '||p_deptno ||' total sal is - '||totsal); 

 

return totsal; 

end; 

 

declare  

res number;  

begin 

 res:=fun_totsa_ofemp(20); 

end; 

 

--37 Create a PL/SQL function to find the average salary of  

--employees in a given branch.  

 

create or replace function f_avg_salbranchno(p_branchno in number) 

return number 

as 

avgsal number; 

begin  

 select avg(sal)into avgsal from emp where branchno=p_branchno; 

 return avgsal; 

end; 

 

declare  

average_sal number; 

begin 

average_sal:= F_AVG_SALBRANCHNO(102); 

dbms_output.put_line('AVERAGE SAL IS '||average_sal); 

end; 

select * from emp; 

 

 

--OR--- 

 

create view emp_branch 

as select e.sal, b.branchname  

from emp e join branch b using(branchno); 

select * from emp_branch; 

 

create or replace function fun_avg_sal_by_branch 

return number 

as 

avgg number:=0; 

begin 

 for rec in (select distinct branchname from emp_branch) 

 loop 

 select avg(sal) into avgg from emp_branch where branchname=rec.branchname; 

DBMS_OUTPUT.PUT_LINE('Average salary in branch ' || rec.branchname || ': ' || avgg); 

 end loop; 

return avgg; 

end; 

 

declare  

avgres number; 

begin 

avgres:=FUN_AVG_SAL_BY_BRANCH; 

end; 

--38 Implement a PL/SQL function to retrieve the name of the  

--branch where a given employee works.  

select* from emp,branch;  

 

create or replace function fun_retrieve_branch( P_ename  in varchar2) 

 return varchar2 

 as  

   bname branch.branchname%type; 

 begin 

 select b.branchname into bname  

 from emp e  join branch b using(branchno) where e.ename =p_ename;  

 return bname; 

 end; 

 declare  

 bname varchar2(20); 

 begin 

 bname:=fun_retrieve_branch('SMITH'); 

 dbms_output.put_line(bname); 

 end; 

  

 

--39 Write a PL/SQL function to determine the number of  

--employees managed by a given manager.  

 

 

create or replace function fun_mgr_empcount(P_mgr in varchar2) 

return varchar2 

as 

empcount number; 

begin 

 

select count(e.ename) into empcount from emp e  

join emp m on  e.mgr= m.empno  

where m.mgr=(select empno from emp where ename='JONES'); 

return empcount; 

end; 

 

 

declare  

emp_count number; 

begin 

emp_count:= FUN_MGR_EMPCOUNT('SMITH'); 

dbms_output.put_line( 'this manager is  managing '|| emp_count||' employees'); 

end; 

 

--40 Create a PL/SQL function to calculate the total commission  

--earned by employees in a given department.  

 

create or replace function fun_totcommission(p_deptno in number ) 

return number 

as 

tot_comm number ; 

begin 

 select sum(nvl(comm,0)) into tot_comm from emp where deptno=p_deptno; 

return tot_comm; 

end; 

 

declare  

tot_comm number; 

begin 

tot_comm:=FUN_TOTCOMMISSION(30); 

dbms_output.put_line( tot_comm); 

end; 

 

 

--41 Write a PL/SQL package named `Emp_Manager` that  

--contains a procedure to retrieve the manager's details for a  

--given employee.  

 create  or replace package Emp_Manager  

 as 

procedure get_manager(p_ename in  emp.ename%type); 

end Emp_Manager; 

 

create or replace package body Emp_Manager as 

procedure get_manager(p_ename in  emp.ename%type) 

as 

manager_name emp.ename%type; 

begin 

select m.ename into manager_name 

from emp e join emp m  on e.mgr =m.empno where e.ename=p_ename; 

dbms_output.put_line(manager_name); 

end get_manager; 

end Emp_Manager; 

 

begin 

Emp_Manager.get_manager('SMITH'); 

end; 

--42 Create a PL/SQL package named `Dept_Info` with a  

--function to return the number of employees in a  

--department.  

create or replace package Dept_Info as 

 function fun_dept_empcount(p_deptno in number ) return number; 

end Dept_Info; 

 

 

create or replace package body Dept_Info as 

function fun_dept_empcount(p_deptno in number) 

return number 

as  

empno number; 

begin 

 select count(*) into  empno from emp where deptno =p_deptno; 

  

 return empno; 

end fun_dept_empcount; 

 

end Dept_Info; 

 

declare 

empcount number; 

begin 

 empcount:=Dept_Info.fun_dept_empcount(20); 

 dbms_output.put_line(empcount); 

end; 

 

--43 Write a PL/SQL package named `Branch_Location` with a  

--procedure to update the location of a branch.  

create or replace package Branch_Location 

AS 

    Procedure update_location 

    (p_bno in branch.branchno%type,new_location in branch.location%type); 

    END Branch_Location; 

 

create or replace package body Branch_Location 

AS 

 

   Procedure update_location(p_bno in branch.branchno%type,new_location in branch.location%type) 

   AS 

   BEGIN 

        Update branch set location=new_location where branchno=p_bno; 

   END; 

 

END Branch_Location; 

 

Declare  

Begin  

    Branch_Location.update_location(102,'hyderabad'); 

end; 

create or replace package Emp_Salary 

AS 

    function total_sal(f_deptno emp.deptno%type) 

    return number; 

END Emp_Salary; 

 

 

create or replace package body Emp_Salary 

AS 

    function total_sal(f_deptno emp.deptno%type) 

    return number 

    AS 

        v_total_sal emp.sal%type; 

    BEGIN 

        select sum(sal) into v_total_sal from emp where deptno=f_deptno; 

        return v_total_sal; 

    END; 

END Emp_Salary; 

 

 

Declare 

    v_total_sal emp.sal%type; 

Begin 

     v_total_sal:=Emp_Salary.total_sal(20); 

     dbms_output.put_line(v_total_sal); 

END; 

 

--Q45.Write a PL/SQL package named `Branch_Dept` with a  

--    procedure to display all departments under a given branch. 

 

Create or replace package Branch_Dept 

AS 

   procedure all_departments(p_bno branch.branchno%type); 

END Branch_Dept; 

 

 

Create or replace package body Branch_Dept 

AS 

   procedure all_departments(p_bno in  branch.branchno%type) 

   AS 

   dept_name dept.dname%type; 

   BEGIN 

       for record_emp in (select distinct deptno from emp where branchno=p_bno) 

       loop 

           select dname into dept_name from dept where deptno=record_emp.deptno; 

           dbms_output.put_line(dept_name); 

       end loop; 

   END; 

END Branch_Dept; 

 

 

 

Declare  

Begin 

     Branch_dept.all_departments(102); 

end; 