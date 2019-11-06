use StudentCourse;

-- drop table ProblemData;
create table if not exists ProblemData(
courseid char(8),
coursename varchar (50),
deptId char(4),
prereqID char(8),
coursetableid int
) ENGINE=innodb;

BEGIN WORK;


INSERT INTO ProblemData (courseid,coursename,deptId,prereqID,coursetableid) 
SELECT courseid,coursename,deptId,prereqID,coursetableid FROM Course 
WHERE courseID='EC1243';

DELETE FROM Course WHERE courseName courseID='EC1243';

commit;

INSERT INTO Course (courseid,coursename,deptId,prereqID,coursetableid) 
SELECT * FROM ProblemData ;