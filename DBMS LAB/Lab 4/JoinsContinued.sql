insert into state values('A',10,'xyz',null);
insert into state values('B',12,'lmn',null);
insert into state values('C',20,'cok',null);

insert into cm values ('M',56,'A');
insert into cm values ('N',70,'B');
insert into cm values ('O',60,null);

update state set cm='M' where stname='A';
update state set cm='N' where stname='B';

SQL> select * from cm;

NAME		  AGE STATE
---------- ---------- --------------------
M		   56 A
N		   70 B
O		   60

STNAME			    POP CAPITAL 	     CM
-------------------- ---------- ----------------
A			     10 xyz		     M
B			     12 lmn		     N
C			     20 cok

select stname,pop from state,cm;
--This gives the cartesian product

select * from (state join cm on cm=name);
//Inner join

select * from (state left outer join cm on cm=name);
--Does a left outer join by showing all the states

select * from (state right outer join cm on cm=name);
--Does a right outer join by showing all the cm

select * from (state full outer join cm on cm=name);
--Does a full outer join by showing all the rows of all tables

