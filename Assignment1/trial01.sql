use lahman2016; 

-- 1(a)

select count(*) from Master where birthDay= 0 or birthMonth=0 or birthYear=0;

-- 1 (b)

select 
(select count(*) from Master
inner join HallOfFame 
on Master.playerID= HallOfFame.playerID
where Master.deathYear =0 or Master.deathDay =0 or Master.deathMonth =0)
-
(select count(*) from Master
inner join HallOfFame 
on Master.playerID= HallOfFame.playerID
where Master.deathYear !=0 or Master.deathDay !=0 or Master.deathMonth !=0) as DifferenceofAliveandDEath;

-- 1(c)
select concat(B.nameGiven,' ',B.nameLast), C.HighestSalary  from
(select A.playerID,(SUM(A.salary)) HIghestSalary from Salaries A group by A.playerID) C
inner join Master B on B.playerID = C.PlayerID 
order by C.HighestSalary desc limit 1;


-- 1 (d)

select avg(HR) as BattingHR from Batting;


-- 1 (e)
select avg(HR) as BattingHR from Batting where HR>=1;


-- 1 (f)

select count(distinct a.playerID)
from
    (select playerID from Batting
    group by playerID
    having avg(HR) > (select avg(HR) from Batting)) as a
inner join
    (select playerID from Pitching
    group by playerID
    having avg(SHO) > (select avg(SHO) from Pitching)) as b
on b.playerID=a.playerID;




select count( distinct playerID) from (select distinct playerID where sum(HR)/count()> (select avg(HR) from Pitching) and
SHO> (select avg(SHO) from Pitching);
# where HR > avg(HR) order by HR;

#and playerID in (select avg(SHO)from Pitching group by playerID)  > (select avg(SHO) from Pitching));

select count(distinct playerID) from Pitching;


select count( distinct playerID) from Pitching where HR> (select avg(HR) from Pitching) and
SHO> (select avg(SHO) from Pitching);

select * from Pitching order by PlayerID,yearID;

#inner join Pitching B on B.playerID=A.playerID
#, avg(C. HR) as PitchingHr 
#inner join Pitching C on C.playerID=A.playerID

select avg(HR) as BattingHR from Batting where HR>0;
#union
#select avg(HR) as PitchingHR from Pitching;

select count(*) from Fielding;
select count(distinct playerID,yearID,stint) from Fielding;
