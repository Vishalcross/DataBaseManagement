/*
Three Scheman Theory:
Physical Schema 
The details regrading the storage of the data. They are always present in a permanent storage medium, like the hardisk.
-Storage Medium
-Record Format

Conceptual Schema
Implementational Data Model
-Relational Data Model
-Object Data Model

External Level Schema
Only give the data which is relevant to a particular user.

Note:
-Generally tables are stored in different files. However, if there is a relationship between two files, they may be stored in the same 
 to save on the access time, such files are called clustered files.
-All the three schemas are independent of one another, so that the change in one layer does not lead to effect in the other.

Physical Data Independence:
Any change in the physicasl level does not affect the logical level

Logical Data Independence:
Any change in the conceptual level does not affect the external level.

View
A view is a combination of attributes of various tables so as to provide required data to the user. As such no new tables are created.
*/

select s.sid,s.sname,count(*) as no_courses from student s,reg r where s.sid=r.sno group by s.sid,s.sname; 
/*

       SID SNAME		NO_COURSES
---------- -------------------- ----------
       109 James			 2
       101 Kiran			 2
       107 Sara 			 2
       105 John 			 3
*/
--The result is a temporary table with the required data

create view std_courses as (select s.sid,s.sname,count(*) as no_courses from student s,reg r where s.sid=r.sno group by s.sid,s.sname);
--However, we do not have the privilages to allow the same
grant create view to Tanmay;
--To provide the user the permission to create views

create view cse_std as (select s.sid,s.sname,s.sage from student s where sbranch='CSE');
--Views are also treated as tables

select * from tab;
/*
TNAME			                TABTYPE	CLUSTERID
------------------------------ ------- ----------
DEPARTMENT		                TABLE
EMP			                    TABLE
BIN$Y28AgZOPsPPgUAB/AQEIPg==$0  TABLE
STATE			                TABLE
CM			                    TABLE
BIN$ZaC8gEbgRdjgUAB/AQEO9w==$0  TABLE
STUDENT 		                TABLE
REG			                    TABLE
COURSE			                TABLE
CSE_STD 		                VIEW
STD_COURSES		                VIEW
*/ 

--View are also stored as metadata in the database
--The tables from which the data is extracted are called base tables
--Views are called virtual tables al they are not permanent, every time a query is executed on the view, it is created on the fly
-- is then automatically deleted.
--We create views so as to prevent any changes within the original tables and so that fresh data is loaded each time from the base tables.
--Some databases provide storage which allows us to avoid the overhead of generating the view each time. This works as long as there are no changes in the base tables.
--Such views are called materialised views.
--Generally views are not meant to be updated, thus, only querrying requests are allowed on the view. This, is because all the data is present in the base table.

insert into reg values (109,40,'D');

--Obtain the sid,sname for all those who have registerd for all 3 credit courses
select s.sid,s.sname from student s where ( (select count(*) from reg r,course c where r.cno=c.cid and c.credits=3 and s.sid=r.sno) = (select count(*) from course where credits=3) );
/*
       SID SNAME
---------- --------------------
       105 John
       107 Sara

*/

select s.sid,s.sname from student s where not exists (( select cid from course where credits=3) minus (select r.cno from reg r where r.sno=s.sid));

select s.sid,s.sname from student s,course c,reg r where c.cid=r.cno and s.sid=r.sno and c.credits=3 group by s.sid,s.sname having count(*)=(select count(*) from course where credits=3);

--get sid,sname for those not registered in any three credit course


select s.sid,s.sname from student s,reg r where s.sid=r.sno and r.cno not in (select cid from course where credits=3);
--Logically Incorrect

select s.sid,s.sname from student s where not exists (select * from reg r,course c where c.cid=r.cno and credits=3 and s.sid=r.sno);