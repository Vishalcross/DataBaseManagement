create table student(sid int primary key,sname varchar(20),sage int,sbranch varchar(10));
create table reg(sno int,cno int,grade char(1), primary key(sno,cno));
create table course(cid int primary key,cname varchar(10),credits int);

alter table reg add constraint student_link foreign key(sno) references student(sid);
alter table reg add constraint course_link foreign key(cno) references course(cid);

/*
Student Table
101 Kiran  19 CSE
104 Mohan  20 EEE
105 John   19 CSE
107 Sara   21 MEC
109 James  20 EEE
110 Ramesh 21 CSE
112 Gopal  20 EEE

Course Table

10 OS   3 
20 DBMS 4
30 MATH 4
40 ARCH 3

Registration

101 20 A
101 30 A
105 10 B
105 20 C
105 40 A
107 10 D
107 40 A
109 20 D
109 30 C
*/

insert into student values(101,'Kiran',19,'CSE');
insert into student values(104,'Mohan',20,'EEE');
insert into student values(105,'John',19,'CSE');
insert into student values(107,'Sara',21,'MEC');
insert into student values(109,'James',20,'EEE');
insert into student values(112,'Gopal',20,'EEE');
insert into student values(110,'Ramesh',21,'CSE');

insert into course values(10,'OS',3);
insert into course values(20,'DBMS',4);
insert into course values(30,'MATH',4);
insert into course values(40,'ARCH',3);

insert into reg values(101,20,'A');
insert into reg values(101,30,'A');
insert into reg values(105,10,'B');
insert into reg values(105,20,'C');
insert into reg values(105,40,'A');
insert into reg values(107,10,'D');
insert into reg values(107,40,'A');
insert into reg values(109,20,'D');
insert into reg values(109,30,'C');

--Find the total number of students
select count(sid) as number_of_students from student;
/*
NUMBEROFSTUDENTS
----------------
	       7
*/

--Find the number of student in each branch
select count(sid),sbranch from student group by sbranch;

/*
COUNT(SID) SBRANCH
---------- ----------
	 3     EEE
	 1     MEC
	 3     CSE
*/

--Find the number of groups that have at least 2 students
select count(sid) as number_of_students,sbranch from student group by sbranch having count(sid)>1;

/*
NUMBER_OF_STUDENTS SBRANCH
------------------ ----------
		 3 EEE
		 3 CSE
*/

--Find the average of the age of CSE students
select avg(sage) as average_age from student where sbranch='CSE';

/*
AVERAGE_AGE
-----------
 19.6666667

*/

/* If we wish to apply conditions on groups we use having
   If we want to apply conditions on tuples we use where
*/

--Find the sid and the number of courses registered by the student
select sno as student_number,count(cno) as number_of_courses from reg group by sno;

/*
STUDENT_NUMBER NUMBER_OF_COURSES
-------------- -----------------
	   101		       2
	   105		       3
	   107		       2
	   109		       2
*/

--Find the sid and the number of courses, for students which are registered in more than two courses
select sno as student_number,count(cno) as number_of_courses from reg group by sno having count(cno)>2;

/*
STUDENT_NUMBER NUMBER_OF_COURSES
-------------- -----------------
	   105		       3
*/

--Find sid,sname and the number of students which have registered for atleast one course
select s.sid,s.sname,count(r.cno) from reg r,student s where s.sid=r.sno group by (s.sid,s.sname) having count(r.cno)>=1;

/*
       SID SNAME		COUNT(R.CNO)
---------- -------------------- ------------
       109 James			   2
       101 Kiran			   2
       107 Sara 			   2
       105 John 			   3
*/

--Find cid and course name the number of students registered for the course if it has at least one student
select c.cid,c.cname,count(r.cno) from reg r,course c where c.cid=r.cno group by(c.cid,c.cname) having count(r.cno)>=1;

/*
       CID CNAME      COUNT(R.CNO)
---------- ---------- ------------
	20 DBMS 		 3
	40 ARCH 		 2
	10 OS			 2
	30 MATH 		 2
*/

/* Query within another query is a nested query
*/

--Find sid,sname if they have registered for OS
--Step 1
select r.sno from reg r,course c where r.cno=c.cid and c.cname='OS'; 

/*
SNO
----------
    105
    107
*/

--Step 2 Use nested query
select s.sid,s.sname from student s where s.sid in (select r.sno from reg r,course c where r.cno=c.cid and c.cname='OS');

/*
SID SNAME
---------- --------------------
       105 John
       107 Sara
*/

--or make use of
select r.sno from reg r where r.cno in ( select c.cid from course c where c.cname='OS');

/*
SNO
----------
       105
       107
*/
/*
The inner query is executed only once
*/

--Find sid,sname for those not registered in any course
select s.sid,s.sname from student s,reg r where s.sid=r.sno group by (s.sid,s.sname) having count(r.cno)=0; 
--This does not work as the inner join ignores the rows which are not present in both
select s.sid,s.sname from student s where s.sid not in (select s.sid from reg r,student s where s.sid=r.sno);

/*
  SID SNAME
---------- --------------------
       104 Mohan
       112 Gopal
       110 Ramesh
*/

select s.sid,s.sname from student s where not exists (select * from reg r where s.sid=r.sno);
/*
Correlated nested query
We make use of the data within the outer query in the inner query

Exists checks each tuple of the outer query and if it returns a non null value it become true

In and not In does a one time execution
*/

/* Tables can be treated like a set of tuples
   We can take advantge of operations like set difference to find the students not in any course
*/
select s.sid,s.sname from student s minus (select s.sid,s.sname from student s, reg r where r.sno=s.sid);

/*
  SID SNAME
---------- --------------------
       104 Mohan
       110 Ramesh
       112 Gopal
*/