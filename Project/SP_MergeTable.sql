CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MergeTables_Baseball`()
BEGIN

    INSERT INTO RequiredData 
    (teamID,`Name`,R,W,Rank) 
	SELECT * FROM ProblemData ;
END