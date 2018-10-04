/*
_______________________________________________
20 March 2018
Tuesday
PL SQl Continued
______________________________________________

Writing Stored Procedures

It is faster than ordinary operations as all the operations are performed at the server side.
It can be resused by any number of programs.
*/

--Write a procedure to update the cost of OS to 900

create or replace procedure proc1 as
	begin 
		update book set cost=900 where bname='OS';
		dbms_output.put_line('The cost of OS has been updated to 900');
	end;
	/

--run the set serveroutput on command every time you login
--exec proc1
--write a stored procedure to find the cost of the book having a particular name
--out parameters connect to the outside world
--in parameters get data from the outside world
create or replace procedure proc2(bookid in number) as 
	price number(3);
	bookName varchar(30);
	begin
		select bname,cost into bookName,price from Book where bid=bookid;
		dbms_output.put_line('Cost of '||bookid||' named '||bookName||' is '||price);
	end;
	/ 

--both work in an identical fashion

create or replace procedure proc2(bookid in number) is price number(3);
	begin
		select cost into price from Book where bid=bookid;
		dbms_output.put_line('Cost of '||bookid||' is '||price);
	end;
	/ 

--The outparameter has the changes taken place in the procedure change the its actual value, which it had in the outside world

create or replace procedure proc3(bookid in number,value out number) as 
	begin 
		select cost into value from book where bid=bookid;
	end;
	/

declare
	price number(3);
	bookno number(4);
begin
	bookno:=1001;
	proc3(bookno,price);
	dbms_output.put_line('Cost of '||bookno||' is '||price);
end;
/

--out param kind of works like a pass by reference in C++

create or replace procedure proc4 as
	begin 
		dbms_output.put_line('process 4 was executed');
	end;
	/

create or replace procedure proc5 as 
	begin 
		proc4;
	end;
	/

--Create a procedure that finds out all the students in that branch and prints the id and the name


create or replace procedure proc6(branch in char(3)) as
	id number(3);
	name varchar(20);
	begin
		select sid,sname into id,name from student where sbranch=branch;
		dbms_output.put_line('The name is:'||name||' and the id:'||id);
	end;
	/
--It will not work as we may have multiple rows

/*
A cursor is a construct that can hold the result of an SQL statement
It is a reserved memory in the database server
*/

/*
open:open the cursor 
close:close the cursor
fetch:extract data row by row

There are some attributes which gives the information about the data
%rowcount:it tells how many rows are present in the result
%found:it has true if a row has been extracted in the call to fetch
%isopen:it tells if a cursor is closed or open
*/

create or replace procedure proc6(branch in char(3)) as
	id number;
	name varchar(20);
	cursor student_cursor is select sid from student where sbranch=branch;
	begin
		open student_cursor;
		loop
			fetch student_cursor into id;
			exit when student_cursor%notfound;
			dbms_output.put_line('The name:'||name||' and the id:'||id);
		end loop;
		close student_cursor;
	end;
	/
--The top one does not work
create or replace procedure proc6(branch in varchar2) as
	id number;
	--name varchar(20);
	cursor student_cursor is select sid from student where sbranch=branch;
	begin
		open student_cursor;
		loop
			fetch student_cursor into id;
			exit when student_cursor%notfound;
			dbms_output.put_line('and the id:'||id);
		end loop;
		close student_cursor;
	end;
	/