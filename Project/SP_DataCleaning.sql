CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DataCleaning_Baseball`()
BEGIN
	
	DECLARE `_rollback` BOOL DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
 
	-- drop table ProblemData;
	create table if not exists ProblemData(
	teamID varchar(255),
    `Name` varchar(255),
	R int(11),
    W int(11),
    Rank int(11)
    ) ENGINE=innodb;

	START TRANSACTION;


	INSERT INTO ProblemData (teamID,`Name`,R,W,Rank) 
	SELECT 
    teamID,`Name`,R,W,Rank
    FROM RequiredData 
	WHERE `Name` is Null or R is Null or Rank is Null or W is Null;
    
    -- Assumption 1: The highest number of Games the teams can play is 200 as 165 is the max value in table
    -- Assumption 2: The highest number of Teams that play is 25 as 13 is the max value in table

    INSERT INTO ProblemData (teamID,`Name`,R,W,Rank) 
	SELECT 
    teamID,`Name`,R,W,Rank
    FROM Teams 
	WHERE Rank > 25 or W> 200 or `Name`='';

	DELETE FROM Teams WHERE `Name` is Null or R is Null or Rank is Null or W is Null;
    DELETE FROM Teams WHERE Rank > 25 or W> 200 or `Name`='';

	IF `_rollback`= 1 THEN
			ROLLBACK;
	ELSE
		COMMIT;
	end if;


END