use lahman2016_baseball;

select count(*)from Fielding;

select count(distinct PlayerID,YearID,teamID,POS,stint,ZR) from Fielding;


select * from Fielding order by playerId;


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