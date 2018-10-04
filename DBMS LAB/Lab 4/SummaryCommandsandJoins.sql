
select all dno from emp;
--It also shows all the duplicates

select distinct dno from emp;
--It shows only distinct values in the output

select avg(sal) from emp;
--Finds the average of the salary of all employees

select max(sal) from emp;
--Finds the maximum salary

select min(sal) from emp;
--Finds the minimum salary

select sum(sal) from emp;
--Finds the sum of all the salaries

select count(sal) from emp;
--Finds the number of people in the sal attribute

select avg(sal) from emp where dno=10;
--Finds the average salary for those belonging to department 10

select avg(sal),min(sal),max(sal) from emp where dno=10;
--Shows the average,minimum, maximum  where they belong to department 10

select eno,avg(sal) from emp where dno=10; 
--The problem is that avg only gives a single row, which leads to an error: ORA-00937: not a single-group group function

select eno,ename,sal from emp where sal>avg(sal);
--Again it does not allow us to use avg(sal) as it is a single row table

select sum(sal) from emp where job='Clerk';
--Find out the total salary paid to clerks

select eno,ename from emp where ename like 'S%'; 
--All names starting with S, % represents any character and any number of character

select eno,ename from emp where ename like '%s';
--All names ending with s

select eno,ename from emp where ename like 'S____';
--All names starting with S and only 5 characters in length. We give one replaceable character with the help of _(underscore)

select eno,ename from emp where ename like '_i%';
--All names having i as the second letter

/*Natural join is used when two tables have the same variable which acts like the foreign key, the attribute has to be common
  An equijoin makes attaches the other table when two different table hold the same value.
 |><| is the symbol for the join
 The number of columns is equal to the sum of the columns in both tables
 Those rows having no matches with the other table are dropped.
 Left Outer Join all the tuples in the Left side table is seen irrespective if the match is present.
 Right Outer Join all the tuples in the Right side table is seen irrespective if the match is present.
 All the missing values are filled with NULL
 Outer join will take values from both tables irrespective of wheather both of matches on either side.
*/

select eno,ename,deptname from emp,department where dno=deptno;
//Creates an equijoin for dno and deptno

select eno,ename,deptname from emp,department where dno=deptno and deptname='Accounting';
--Selecting all the people who belong to the accounting department

select eno,ename,deptname from emp,department;
--We get the cartesian product of the two tables

/* We must make sure that we get a unique match that is we must have only one matches in the table, otherwise the data we
   obtain will be inconsistant*/

select eno,ename from (emp join department on dno=deptno) where deptname='Accounting';
//It uses the join keyword to create the equijoin and finds all the people who belong to accounting