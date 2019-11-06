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


-- 2

use lahman2016;

-- declare the primary key of Fielding table as REPLACE works on keys
ALTER TABLE Fielding
ADD CONSTRAINT PK_Fielding PRIMARY KEY (PlayerID,YearID,teamID,POS,stint,ZR);

-- load data from LOCAL location by using REPLACE on duplicate unique valued key

load data local infile 'Documents/ECE656/Assignment1/Fielding.csv' REPLACE
into table Fielding
FIELDS TERMINATED BY ',' 
#ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(playerID,yearID,stint,teamID,lgID,Pos,@vG,GS,InnOuts,@vPO,@vA,@vE,@vDP,PB,WP,SB,CS,ZR)
        SET 
        G       = if(@vG='', 0, @vG),
        PO      = if(@vPO='', 0, @vPO),
        A       = if(@vA='', 0, @vA),
        E       = if(@vE='', 0, @vE),
        DP      = if(@vDP='', 0, @vDP);


-- 3 (2)

-- Adding primary keys;

ALTER TABLE Master
ADD CONSTRAINT PK_Player PRIMARY KEY (playerID);

ALTER TABLE Batting
ADD CONSTRAINT PK_Batting PRIMARY KEY (PlayerID,YearID,stint);

ALTER TABLE Pitching
ADD CONSTRAINT PK_Pitching PRIMARY KEY (PlayerID,YearID,stint);

-- Primary key of Fielding has already been assigned on part 2

-- ALTER TABLE Fielding
-- ADD CONSTRAINT PK_Fielding PRIMARY KEY (PlayerID,YearID,teamID,POS,stint,ZR);

ALTER TABLE AllstarFull
ADD CONSTRAINT PK_AllstarFull PRIMARY KEY (playerID,gameID);

ALTER TABLE HallOfFame
ADD CONSTRAINT PK_HallOfFame PRIMARY KEY (PlayerID,yearID,votedby);

ALTER TABLE Managers
ADD CONSTRAINT PK_Managers PRIMARY KEY (playerID,teamID,yearID,inseason);

ALTER TABLE Teams
ADD CONSTRAINT PK_Teams PRIMARY KEY (teamID,yearID);

ALTER TABLE BattingPost
ADD CONSTRAINT PK_BattingPost PRIMARY KEY (playerID,yearID,round);

ALTER TABLE PitchingPost
ADD CONSTRAINT PK_PitchingPost PRIMARY KEY (playerID,yearID,round);

ALTER TABLE TeamsFranchises
ADD CONSTRAINT PK_TeamsFranchises PRIMARY KEY (franchID);

ALTER TABLE FieldingOF
ADD CONSTRAINT PK_FieldingOF PRIMARY KEY (PlayerID,YearID,stint);

ALTER TABLE FieldingPost
ADD CONSTRAINT PK_FieldingPost PRIMARY KEY (playerID,yearID,round,POS);

ALTER TABLE FieldingOFsplit
ADD CONSTRAINT PK_FieldingOFsplit PRIMARY KEY (playerID,yearID,stint,POS);

ALTER TABLE ManagersHalf
ADD CONSTRAINT PK_ManagersHalf PRIMARY KEY (playerID,yearID,teamID,half);

ALTER TABLE TeamsHalf
ADD CONSTRAINT PK_TeamsHalf PRIMARY KEY (teamID,yearID,half);

ALTER TABLE Salaries
ADD CONSTRAINT PK_Salaries PRIMARY KEY (playerID,yearID,teamID);

ALTER TABLE SeriesPost
ADD CONSTRAINT PK_SeriesPost PRIMARY KEY (yearID,round);

ALTER TABLE AwardsManagers
ADD CONSTRAINT PK_AwardsManagers PRIMARY KEY (playerID,yearID,awardID);

ALTER TABLE AwardsPlayers
ADD CONSTRAINT PK_AwardsPlayers PRIMARY KEY (playerID,yearID,awardID,lgID);

ALTER TABLE AwardsShareManagers
ADD CONSTRAINT PK_AwardsShareManagers PRIMARY KEY (playerID,yearID,awardID);

ALTER TABLE AwardsSharePlayers
ADD CONSTRAINT PK_AwardsSharePlayers PRIMARY KEY (playerID,yearID,awardID);

ALTER TABLE Appearances
ADD CONSTRAINT PK_Appearances PRIMARY KEY (playerID,teamID,yearID);

ALTER TABLE Schools
ADD CONSTRAINT PK_Schools PRIMARY KEY (schoolID);

ALTER TABLE CollegePlaying
ADD CONSTRAINT PK_CollegePlaying PRIMARY KEY (playerID,schoolID,yearID);

ALTER TABLE Parks
ADD CONSTRAINT PK_Parks PRIMARY KEY (`park.key`);

ALTER TABLE HomeGames
ADD CONSTRAINT PK_HomeGames PRIMARY KEY (`team.key`,`year.key`,`park.key`);

-- Adding Foreign Keys

-- turning off checking missing values in order to set foreign keys

set Foreign_key_checks=0;

ALTER TABLE Batting
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE Batting
ADD FOREIGN KEY (teamID, yearID) REFERENCES Teams (teamID, yearID);

ALTER TABLE Pitching
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE Pitching
ADD FOREIGN KEY (teamID, yearID) REFERENCES Teams (teamID, yearID);

ALTER TABLE Fielding
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE Fielding
ADD FOREIGN KEY (teamID, yearID) REFERENCES Teams (teamID, yearID);

ALTER TABLE Fielding
ADD FOREIGN KEY (PlayerID,YearID,stint) REFERENCES FieldingOF (PlayerID,YearID,stint);

ALTER TABLE Fielding
ADD FOREIGN KEY (playerID,yearID,stint,POS) REFERENCES FieldingOFsplit (playerID,yearID,stint,POS);

ALTER TABLE AllstarFull
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE AllstarFull
ADD FOREIGN KEY (teamID, yearID) REFERENCES Teams (teamID, yearID);

ALTER TABLE AllstarFull
ADD FOREIGN KEY (playerID,teamID,yearID) REFERENCES Appearances (playerID,teamID,yearID);

ALTER TABLE HallOfFame
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE Managers
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE Managers
ADD FOREIGN KEY (teamID, yearID) REFERENCES Teams (teamID, yearID);

ALTER TABLE Teams
ADD FOREIGN KEY (franchID) REFERENCES TeamsFranchises(franchID);

ALTER TABLE BattingPost
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE BattingPost
ADD FOREIGN KEY (yearID,round) REFERENCES SeriesPost (yearID,round);

ALTER TABLE PitchingPost
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE PitchingPost
ADD FOREIGN KEY (yearID,round) REFERENCES SeriesPost (yearID,round);

ALTER TABLE FieldingOF
ADD FOREIGN KEY (playerID) REFERENCES Master (playerID);

ALTER TABLE FieldingPost
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE FieldingPost
ADD FOREIGN KEY (yearID,round) REFERENCES SeriesPost (yearID,round);

ALTER TABLE FieldingOFsplit
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE ManagersHalf
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE ManagersHalf
ADD FOREIGN KEY (playerID,teamID,yearID,inseason) REFERENCES Managers (playerID,teamID,yearID,inseason);

ALTER TABLE TeamsHalf
ADD FOREIGN KEY (teamID,yearID) REFERENCES Teams (teamID,yearID);

ALTER TABLE Salaries
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE Salaries
ADD FOREIGN KEY (teamID,yearID) REFERENCES Teams (teamID,yearID);

ALTER TABLE AwardsManagers
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE AwardsPlayers
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE AwardsShareManagers
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE AwardsShareManagers
ADD FOREIGN KEY (playerID,yearID,awardID) REFERENCES AwardsManagers(playerID,yearID,awardID);

ALTER TABLE AwardsSharePlayers
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE AwardsSharePlayers
ADD FOREIGN KEY (playerID,yearID,awardID,lgID) REFERENCES AwardsPlayers(playerID,yearID,awardID,lgID);

ALTER TABLE Appearances
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE Appearances
ADD FOREIGN KEY (teamID,yearID) REFERENCES Teams (teamID,yearID);

ALTER TABLE CollegePlaying
ADD FOREIGN KEY (playerID) REFERENCES Master(playerID);

ALTER TABLE CollegePlaying
ADD FOREIGN KEY (schoolID) REFERENCES Schools (schoolID);

ALTER TABLE HomeGames
ADD FOREIGN KEY (`park.key`) REFERENCES Parks (`park.key`);

-- turning back on checking missing values as foreign keys are already in place

set foreign_key_checks=1;