CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SplitTable_Baseball`()
BEGIN
	create table if not exists RequiredData(
    teamID varchar(255),
    `Name` varchar(255),
	R int(11),
    W int(11),
    Rank int(11)
    )ENGINE=innodb;
    
    
    insert into RequiredData(teamID,`Name`,R,W,Rank)
    select teamID,`Name`,R,W,Rank from Teams;
END