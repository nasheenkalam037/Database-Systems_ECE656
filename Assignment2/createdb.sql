create database if not exists StudentCourse;
use StudentCourse;
drop table if exists Offering;
drop table if exists Instructor;
drop table if exists Course;
drop table if exists Classroom;
drop table if exists Department;

create table Classroom (roomID char(8), Building char(4), Room decimal(4), Capacity int);
insert into Classroom values ('E74417', 'E7', 4417, 138),
       	    	      	     ('E74053', 'E7', 4053 , 144 ),
			     ('RCH111' , 'RCH' , 111 , 91 ),
			     ('RCH101' , 'RCH', 101 , 250 );


create table Department (deptID char(8), deptName varchar(50), faculty varchar(50));
insert into Department values ('ECE' , 'Electrical and Computer Engineering' , 'Engineering' ),
       	    	       	      ('CS'  , 'Computer Science' , 'Math' ),
			      ('MATH'  , 'Math' , 'Math' ),
			      ('C&O'  , 'Combinatorics and Optimization' , 'Math' );

create table Instructor(instID int, instName char(10), deptID char(4), sessional bool);
insert into Instructor values (1 , 'Nelson' , 'ECE' , false ),
       	    	       	      (3 , 'Jimbo'  , 'ECE' , false   ),
			      (4 , 'Moe'    , 'CS'  , true ),
			      (5 , 'Lenny'  , 'CS'  , false   );

create table Course (courseID char(8), courseName varchar(50), deptID char(4), prereqID char(8));
insert into Course values ('ECE356'  , 'Database Systems' , 'ECE' , 'ECE250' ),
       	    	   	  ('ECE358'  , 'Computer Networks' , 'ECE' , 'ECE222' ),
			  ('ECE390'  , 'Engineering Design' , 'ECE' , 'ECE290' ),
			  ('MATH117' , 'Calculus 1'  , 'MATH'  , null );

create table Offering (courseID char(8), section int, termCode decimal(4), roomID char(8), instID int, enrollment int);
insert into Offering values ('ECE356'  , 1 , 1191 , 'E74417' , 1 , 64 ),
       	    	     	    ('ECE356'  , 2 , 1191 , 'E74417' , 3 , 123   ),
			    ('ECE290'  , 1 , 1191 , 'E74053' , 3 , 102 ),
			    ('ECE390'  , 1 , 1191 , 'E74053' , 3 , 102 ),
			    ('MATH117' , 1 , 1189 , 'RCH111' , 5 , 134 );