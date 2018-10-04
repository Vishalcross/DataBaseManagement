/*
_______________________________________________
13 March 2018
Tuesday
______________________________________________

SQL
Structured Query Language
It is a language that can be used for relational databases.


Formal Query Language
	It uses formal math to define the database and write queries
	Relational Algebra
	Tuple Calculus
	<- Select in Relational Algebra
	|><| Join in Relational Algebra

Commercial Query Language
	It is easy for the end users to write queries and does not require formal knowledge

Classification of Languages
	Procedural
		It specifies about the procedure to be performed on the data within the database
		Relational Algebra is procedural in nature
	Declarative
		It tells only about what we want, we dont have to define the procedures to be performed.
		SQL is declarative in nature.

Query engines find the relational algebra easier to handle, thus, queries are converted into relational algebra form which in turn
is evaluated with ease as it is a procedural language.

SQL lacks flow of control instructions like looping and if statements as well as variables.

PLSQL overcomes the limitations of SQL by adding programming language features.
PLSQL is specific to oracle. 

Persistant Store Modules
	It allows us to store the commands to be executed permanently in the database server, so that the instructions can be reused.
	These modules are named so that we can reference the code associated within the  module.

Features-
	Anonymous Code Blocks
		Sequence of instructions ment for one time execution.
	Stored Procedures
		Named procedures that can be reused, by calling the function. It can also contain parameters.
	SQL Functions
		Procedures cannot return values, otherwise they are identical to stored procedures.
	Triggers
		We want some code to be executed when a particular operation takes place on the table. These invoke whenever a  particular condition is satisfied.
		For example an auto update on a table to store the number of items of a particular type, when the original table changes.
	Cursors
		It is used to traverse the database and perform operations while traversing throught the database		
	Sequences
		Values that keep incrementing, so that we can use this set of non-repeating enteries for the primary key or to label transactions.
*/

create table Book (bid int,bname varchar(20),cost int,primary key(bid));
insert into Book values(1001,'OS',700);
insert into Book values(1003,'DBMS',800);

set serveroutput on;--This enables the output to the terminal
begin 
	dbms_output.put_line('Hello World');
end;
/
--The / is required to terminate the input

begin
	insert into Book values(1000,'Architecture',900);
	dbms_output.put_line('Added a tuple into the Book table');
end;
/

declare
	id number(3); --Number with three digits
	name varchar(15);
begin 
	id:=101;
	name:='Godfetalis';
	dbms_output.put_line('Id is:'||id||' and the name is:'||name);--|| acts like concatinate operator
end;
/

declare 
	bcost number(3);
begin 
	select cost into bcost from Book where bid=1003;
	dbms_output.put_line('Cost of book 1003 is:'||bcost);
end;
/
--even if we use cost in place of bcost, it will continue to work as the cost in select refers to the attribute in the table.

--Append Kumar to the student having the sid 104
declare 
	name varchar(20);
begin 
	select sname into name from student where sid=104;
	update student set sname=(name||' Kumar') where sid=104;
end;
/

--For bid 1001 display: Name is: OS and Cost is 700
declare 
	name varchar(20);
	bcost number(3);
begin
	select bname,cost into name,bcost from Book where bid=1001;
	dbms_output.put_line('The name is:'||name||' the cost is:'||bcost);
end;
/

--Find the number of students in the database
declare
	num int;
begin
	select count(*) into num from student;
	dbms_output.put_line('The number of students currently present:'||num);
end;
/

--count is illegal as it is reserved, thus, it cannot be used as a variable name.

--loop numbers from 100 to 1000 in steps of 50
declare 
	n number(4);
begin
	n:=100;
	loop
		dbms_output.put_line('value is:'||n);
		n:=n+50;
		exit when n>1000;
	end loop;
end;
/

--Check if the number is greater than 60
declare 
	n number(4);
begin
	n:=80;
	if n>60 then
		dbms_output.put_line('It works');
	end if;
end;
/