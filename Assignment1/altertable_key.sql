ALTER TABLE Master
ADD CONSTRAINT PK_Master PRIMARY KEY (playerID);

select * from Batting where yearID not in (select yearID from Batting);

use lahman2016;
select count(*) from AllstarFull;
select count(distinct playerID,gameID) from AllstarFull;

Select count(*) FieldingPost 
FROM FieldingPost
        LEFT JOIN
    Fielding ON Fielding.playerID = FieldingPost.playerID 
WHERE
    Fielding.yearID  IS NULL;