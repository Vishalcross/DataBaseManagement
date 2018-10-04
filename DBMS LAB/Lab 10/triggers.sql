/*
/*
_______________________________________________
3 April 2018
Tuesday
PL SQl Continued-Triggers

______________________________________________
*/

create table publisher(pubname varchar(10),city varchar(10),numOfBooks int,primary key(pubname));

create table book(bid int,bname varchar(10),cost int,publisher varchar(10),foreign key(publisher) references publisher(pubname),primary key(bid));

insert into publisher values('TATA','Delhi',0);
insert into publisher values('PHI','Mumbai',0);

--Remember to add the permission for triggers
--Also set serveroutput on
--Here the trigger notifies us everytime a record is inserted to the book table.
create or replace trigger t1 before insert on book
	begin
		dbms_output.put_line('New record is inserted');
	end;
	/
--Add rows to observe the trigger in action
insert into book values(101,'OS',700,'TATA');
insert into book values(104,'CNW',400,'TATA');

create or replace trigger t2 after insert on book 
	declare
		numOfRecords int;
	begin 
		select count(*) into numOfRecords from book;
		dbms_output.put_line('The number of books present are:'||numOfRecords);
	end;
	/

insert into book values(106,'DBMS',400,'PHI');

create or replace trigger t3 after update on book
	for each row
		begin 
			dbms_output.put_line('A row has been updated');
		end;
		/

create or replace trigger t4 after update on book
	begin 
		dbms_output.put_line('This is a table level trigger to warn that the table has been updated');
	end;
	/

update book set cost=500;
/*
A row has been updated
A row has been updated
A row has been updated
This is a table level trigger to warn that the table has been updated
*/

--Create a trigger that tells us the new values added to book
create or replace trigger t5 after insert on book
	--for each row
		begin 
			dbms_output.put_line('The new records are ID:'||:new.bid||'COST:'||:new.cost);
		end;
		/
/*
ERROR at line 1:
ORA-04082: NEW or OLD references not allowed in table level triggers
As we can have more than one updation....
*/

--The correct way is
create or replace trigger t5 after insert on book
	for each row
		begin 
			dbms_output.put_line('The new records are ID:'||:new.bid||' COST:'||:new.cost);
		end; 
		/

insert into book values(107,'JAVA',200,'PHI');
-- New record is inserted
-- The new records are ID:107 COST:200
-- The number of books present are:4

--create a trigger on the update to find the old and the new cost
create or replace trigger t6 after update on book
	for each row
		begin
			dbms_output.put_line('Id:'||:new.bid||' Old Price:'||:old.cost||' New Price:'||:new.cost);
		end;
		/

--Write a trigger that finds out the number of books of the publisher of the newly added book are present;
create or replace trigger t7 after insert on book
	declare 
		numberOfRecords int;
	for each row
		begin
			select count(*) into numberOfRecords from book where publisher=:new.publisher;
			update publisher set numOfBooks=numberOfRecords where pubname=:new.publisher;
		end;
		/