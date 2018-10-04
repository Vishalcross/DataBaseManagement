--A function that takes the sid and gives back the age of the student
create or replace function F1(arg in number) return number is
	var number;
	begin
		select sage into var from student where sid=arg;
		return var;
	end;
	/

create or replace procedure F2(arg in number) as
	age number;
	begin
		age:=F1(arg);
		dbms_output.put_line('For Student Id:'||arg||' age is:'||age);
	end;
	/

create or replace function F3(length in number, breadth in number) return number is
	area number;
	begin 
		area:=length*breadth;
		return area;
	end;
	/

create or replace procedure F4(length in number,breadth in number) as
	area number;
	begin
		area:=F3(length,breadth);
		dbms_output.put_line('The area is:'||area);
	end;
	/

--A sequence generates unique values which allows us to fill a primary key without worrying about the value given
create table part(pid int primary key,pname varchar(10),cost int);

--grant create sequence To Tanmay;
create sequence part_seq start with 1001;

insert into part values (part_seq.nextVal,'BOLT',10);

insert into part values (part_seq.nextVal,'NUT',5);

select * from part;

/* 
      PID PNAME	    COST
---------- ---------- ----------
      1001 BOLT 	      10
      1002 NUT		       5
*/


/*
get cid and cname for those having at least 3 registrations
get sid and sname for those having age greater than the average age
get sid,sname for those not registered in any 4 credit course
get students who have registered for all 3 credit courses
get cid and cname for those who have registered are 19 years old
get sid,sname and number of a greades obtainded
get cid,cname and number of students registered
*/
--get cid and cname for those having at least 3 registrations
select r.cno,c.cname from reg r,course c where c.cid=r.cno group by (r.cno,c.cname) having (select count(*) from reg r2 group by r2.cno having r2.cno=r.cno)=3;
--get sid and sname for those having age greater than the average age
select sid,sname from student where sage>(select avg(sage) from student);
--get sid,sname for those not registered in any 4 credit course
select sid,sname from student where not exists(select sno from reg where cno in (select cid from course where credits=4) and sno=sid) and sid in (select sno from reg where sid=sno);
--get students who have registered for all 3 credit courses
select sid,sname from student where (select count(*) from reg where sno=sid and cno in (select cid from course where credits=3))=(select count(*) from course where credits=3);
--get cid and cname for those who have registered are 19 years old
