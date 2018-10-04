select eno,ename,sal,deptname from emp,department where dno=deptno;
--Gets the information of the employee number,name,salary and departent by joining employee and department

/*Perfroming a self join when a table has a relationship with respect to itself */

select e1.eno,e1.ename,e2.ename from emp e1,emp e2 where e1.mgr=e2.eno;
--Get the employee number along with the name of the employee and the employees manager
--Note the president does not appear in the result
--If we want the president use the left outer join

select sysdate from dual;
--Gives us a 1x1 table containing todays date
/*
SYSDATE
---------
06-FEB-18
*/

select chr(97) from dual;
--Returns the letter corrosponding to the input ascii value
/*
C
-
a
*/

select concat('Hello',' World') from dual;
--Concatinates the input words
/*
CONCAT
-----------
Hello World
*/

select concat(ename,job) from emp;
--However we can only concatinate only two at a time

select instr('Hello','e') from dual;
--It gives the position of the first occurence of the character to be found

select length('Hello') from dual;
--Gives the length of the input string

select lpad('H',4,'S') from dual;
--Pads the left hand side with a specific character 
/*
LPAD
----
SSSH
*/
select ltrim('    Hello') from dual;
--Trims the extra whitespaces
/*
LTRIM
-----
Hello
*/

select replace('Hello sir','sir','madam') from dual;
--Replaces sir by madam

select replace(ename,'es','os') from emp where ename like '%es';
--Replace the last two letters of every person ending with es to os

select substr('Hello World',1,2) from dual;
--Finds the substring and is 1 indexed and the next argument gives the length
select initcap('hello') from dual;
--Converts the first letter to upper case
/*
INITC
-----
Hello
*/

select upper('hello') from dual;
--Convers into upper case

select translate('Hello*World#Here*We#Come','*#','_$') from dual;
--Replaces in the order corrosponding to the arguments
/*
TRANSLATE('HELLO*WORLD#H
------------------------
Hello_World$Here_We$Come
*/

select abs(-13.46) from dual;
--Gives the absolute value of the input

select ceil(13.46) from dual;
--Gives the smallest integer greater than equal to the current number

select mod(12,10) from dual;
--obtains the value of 12%10 namely 2

select power(2,5) from dual;
--finds the 5th power of 2 which is 32

select round(12.945) from dual;
--rounds the number by rounding it to the closest integer

select sign(23) from dual;
/*
if(n<0){
  return -1;
}
else if(n==0){
  return 0;
}
else{
  return 1;
}
*/

select sqrt(37) from dual;
--It provides the float value of the square root of the value

SELECT TRUNC(15.79,1) "Truncate" FROM DUAL;
--Truncates to one decimal point and does not round off to the closest value

select add_months('04-FEB-18',4) from dual;
--Adds four months to the current month
/*
ADD_MONTH
---------
04-JUN-18
*/
select last_day('06-jan-18') from dual;
--Gives the last day of the month
/*
LAST_DAY(
---------
31-JAN-18
*/
select last_day(sysdate) "Last Day" from dual;
--Gives the last day of the month
/*
Last Day
---------
28-FEB-18
*/
select next_day(sysdate,'tue') "Next Day" from dual;
--We find the next day given in the argument sysdate=6 feb 18
/*
Next Day
---------
13-FEB-18
*/
select greatest(1,2,3,4,5) from dual;
--Finds the greates number in the list

select least(1,2,3,4,5) from dual;
--Finds the least number in the list

select to_char(sysdate,'mm-dd-yyyy hh:mi:ss') from dual;
--Provides the time in the specific format

select eno,ename,sal+comm as package from emp;
--Gets the employee number.name and the sum of salary and the commission as a new column as package
--Those employees who do not have a commission give back null as the package

select eno,ename from emp where to_char(hiredate,'yyyy')=1980; 
--Finds all the people with hiredate 1980

select to_date('16-may-2018') - sysdate from dual;
--This converts it from the string equivalent of the date to the date type and finds how many days are left for the semester to end

select eno,ename,to_char(hiredate,'yyyy') from emp;
--Display the details along with the year of joining

select eno as "Employee Number",ename as "Name" from emp where hiredate > to_date('31-dec-1980'); 
select eno as "Employee Number",ename as "Name" from emp where to_char(hiredate,'yyyy')>1980; 
--Get the details of the people who joined after 1980