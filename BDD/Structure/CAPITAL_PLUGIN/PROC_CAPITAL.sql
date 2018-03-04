

DROP PROCEDURE IF EXISTS CAPITAL_1_IMPORT;
DROP PROCEDURE IF EXISTS CAPITAL_2_IMPORT;

DROP VIEW IF EXISTS WARN_TIME_CAP;

CREATE VIEW `WARN_TIME_CAP`  AS  select `cap`.`userName` AS `userName`,`cap`.`dateYear` AS `dateYear`,`cap`.`dateWeek` AS `dateWeek`,
`cap`.`dateDay` AS `dateDay`,sum(`cap`.`timeConsume`) AS `SUM_TIME`,'W1 - time of day > 8h' AS `warnMessage` 
from `CAPITAL_IMPUTATION` `cap` 
group by `cap`.`userName`,`cap`.`dateYear`,`cap`.`dateWeek`,`cap`.`dateDay` 
having (sum(`cap`.`timeConsume`) > 8)
 union select `cap`.`userName` AS `userName`,`cap`.`dateYear` AS `dateYear`,`cap`.`dateWeek` AS `dateWeek`,'' AS `Name_exp_4`,sum(`cap`.`timeConsume`) AS `SUM_TIME`,'W2 - time of week > 40h' AS `W2 - time of week > 40h` from `CAPITAL_IMPUTATION` `cap` group by `cap`.`userName`,`cap`.`dateYear`,`cap`.`dateWeek` having (sum(`cap`.`timeConsume`) > 40) ;
 
DELIMITER $$
--
-- Procédures
--
CREATE PROCEDURE CAPITAL_1_IMPORT ()  BEGIN
	   
	UPDATE CAPITAL_IMPUTATION SET user_id=(SELECT DISTINCT id FROM GISMO_USER WHERE GISMO_USER.CAPITAL_name=CAPITAL_IMPUTATION.userName);

	UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.capitalOSId=(SELECT DISTINCT id FROM CAPITAL_OS WHERE CAPITAL_OS.name=CAPITAL_IMPUTATION.osName);

	UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.weekId=(SELECT DISTINCT id FROM GISMO_WEEK_NUMBER WHERE GISMO_WEEK_NUMBER.dateYear=CAPITAL_IMPUTATION.dateYear AND GISMO_WEEK_NUMBER.dateWeek=CAPITAL_IMPUTATION.dateWeek AND GISMO_WEEK_NUMBER.dateDay=CAPITAL_IMPUTATION.dateDay);

	UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.project_id = (SELECT DISTINCT CAPITAL_OS.project_id FROM CAPITAL_OS WHERE CAPITAL_OS.id = CAPITAL_IMPUTATION.capitalOSId);
	
	UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.version_id = (SELECT DISTINCT CAPITAL_OS.version_id FROM CAPITAL_OS WHERE CAPITAL_OS.id = CAPITAL_IMPUTATION.capitalOSId);
	
	UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.sub_project_id = (SELECT DISTINCT GISMO_SUB_PROJECT.id FROM GISMO_SUB_PROJECT , CAPITAL_ITEM WHERE GISMO_SUB_PROJECT.project_id = CAPITAL_IMPUTATION.project_id AND CAPITAL_IMPUTATION.item = CAPITAL_ITEM.name AND GISMO_SUB_PROJECT.name = CAPITAL_ITEM.subProject_name) ;

	UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.task_type_id = (SELECT DISTINCT CAPITAL_SUBTYPE.task_type_id FROM CAPITAL_SUBTYPE WHERE CAPITAL_SUBTYPE.capitalSubType = CAPITAL_IMPUTATION.subType AND CAPITAL_SUBTYPE.capitalItem = CAPITAL_IMPUTATION.item AND CAPITAL_SUBTYPE.project_id = CAPITAL_IMPUTATION.project_id);

	UPDATE CAPITAL_IMPUTATION SET warning = null, error = null;

	UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.error = 'E1 - No user (change configuration) ' WHERE CAPITAL_IMPUTATION.user_id is null and CAPITAL_IMPUTATION.error is null;

	UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.error = 'E2 - No project (check OS configuration) ' WHERE CAPITAL_IMPUTATION.capitalOSId is null and CAPITAL_IMPUTATION.error is null;

	UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.error = 'E3 - No sub project (check ITEM configuration) ' WHERE CAPITAL_IMPUTATION.sub_project_id is null and CAPITAL_IMPUTATION.error is null;

	UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.error = 'E4 - No task type (check SUBTYPE configuration) ' WHERE CAPITAL_IMPUTATION.task_type_id is null and CAPITAL_IMPUTATION.error is null;

	UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.error = ' E5 - No week recognize (check WEEK/DATE configuration) ' WHERE CAPITAL_IMPUTATION.weekId is null and CAPITAL_IMPUTATION.error is null;

	UPDATE CAPITAL_IMPUTATION as cap SET cap.warning = 'W0 - work on weekend' WHERE cap.dateDay in ('SUNDAY', 'SATRUDAY') and cap.error is null;
  
	UPDATE CAPITAL_IMPUTATION as cap SET cap.warning = ( SELECT warn.warnMessage FROM WARN_TIME_CAP warn
														 WHERE warn.userName = cap.userName AND warn.dateYear = cap.dateYear 
														 AND warn.dateWeek = cap.dateWeek AND warn.dateDay = cap.dateDay
														 AND cap.warning is null AND cap.error is null) 
	WHERE exists (SELECT * FROM WARN_TIME_CAP warn
				  WHERE warn.userName = cap.userName AND warn.dateYear = cap.dateYear 
				  AND warn.dateWeek = cap.dateWeek AND warn.dateDay = cap.dateDay
				  AND cap.warning is null AND cap.error is null);

	
END$$


DELIMITER ;

DELIMITER $$

CREATE PROCEDURE CAPITAL_2_IMPORT ()  
BEGIN

	-- TREAT the imputation with complements (get the task_id)
	UPDATE CAPITAL_IMPUTATION SET complement = null WHERE complement = '' OR complement = '0';
	UPDATE CAPITAL_IMPUTATION SET  comment = null WHERE comment = '' OR comment = '0';
	UPDATE CAPITAL_IMPUTATION SET  task_id = null ;
	UPDATE GISMO_TASK SET external_id = null WHERE external_id = '' OR external_id = '0';
	
	UPDATE CAPITAL_IMPUTATION SET comment = CONCAT(subType, '#', item) WHERE comment is null;
	
	-- CREATE the missing task 
	INSERT INTO GISMO_TASK(external_id, task_type_id, project_Id, version_id, sub_project_id, state) 
		SELECT distinct CAPITAL_IMPUTATION.complement, CAPITAL_IMPUTATION.task_type_id, CAPITAL_IMPUTATION.project_id, CAPITAL_IMPUTATION.version_id,CAPITAL_IMPUTATION.sub_project_id, 'IN_PROGRESS'
		FROM CAPITAL_IMPUTATION 
		WHERE CAPITAL_IMPUTATION.complement is not null 
		AND CAPITAL_IMPUTATION.warning is null AND CAPITAL_IMPUTATION.error is null 
		AND CAPITAL_IMPUTATION.task_id is null 
		AND CAPITAL_IMPUTATION.complement not in (SELECT DISTINCT external_id FROM GISMO_TASK);
	-- UPDATE the task_id
	UPDATE CAPITAL_IMPUTATION SET task_id = (SELECT distinct id FROM GISMO_TASK WHERE GISMO_TASK.external_id = CAPITAL_IMPUTATION.complement AND GISMO_TASK.external_id != '' AND CAPITAL_IMPUTATION.sub_project_id = GISMO_TASK.sub_project_id AND GISMO_TASK.task_type_id = CAPITAL_IMPUTATION.task_type_id AND CAPITAL_IMPUTATION.version_id = GISMO_TASK.version_id) WHERE CAPITAL_IMPUTATION.complement is not null;

	-- TREAT the imputation without complements and with comments (get the task_id)
	-- CREATE the missing task 
	INSERT INTO GISMO_TASK(external_id, name, task_type_id, project_Id, version_id, sub_project_id, state) 
	SELECT distinct CONCAT('CAPITAL_', CAPITAL_IMPUTATION.comment), CAPITAL_IMPUTATION.comment, CAPITAL_IMPUTATION.task_type_id, CAPITAL_IMPUTATION.project_id, CAPITAL_IMPUTATION.version_id, CAPITAL_IMPUTATION.sub_project_id, 'IN_PROGRESS'
	FROM CAPITAL_IMPUTATION 
	WHERE CAPITAL_IMPUTATION.comment is not null 
	AND CAPITAL_IMPUTATION.warning is null AND CAPITAL_IMPUTATION.error is null AND CAPITAL_IMPUTATION.task_id is null 
	AND CONCAT('CAPITAL_', CAPITAL_IMPUTATION.comment) not in (SELECT DISTINCT external_id FROM GISMO_TASK);
	-- UPDATE the task_id
	UPDATE CAPITAL_IMPUTATION SET task_id = (SELECT distinct id FROM GISMO_TASK WHERE GISMO_TASK.external_id like CONCAT('CAPITAL_', CAPITAL_IMPUTATION.comment) AND GISMO_TASK.external_id != '' AND CAPITAL_IMPUTATION.sub_project_id = GISMO_TASK.sub_project_id AND GISMO_TASK.task_type_id = CAPITAL_IMPUTATION.task_type_id AND CAPITAL_IMPUTATION.version_id = GISMO_TASK.version_id) WHERE CAPITAL_IMPUTATION.comment is not null and CAPITAL_IMPUTATION.task_id is null;
	 
	-- Update the existing GISMO imputation of the same task on the same user on the same day (modification of imputTime)
	UPDATE GISMO_IMPUTATION GISMO SET imputTime = (SELECT DISTINCT cap.timeConsume FROM CAPITAL_IMPUTATION as cap, GISMO_WEEK_NUMBER as week 
												   WHERE cap.weekId = week.id and cap.error is null 
												   AND cap.task_id = GISMO.task_id and cap.user_id = GISMO.user_id AND week.date = GISMO.imputDate)
	WHERE EXISTS (SELECT * FROM CAPITAL_IMPUTATION as cap, GISMO_WEEK_NUMBER as week 
				   WHERE cap.weekId = week.id and cap.error is null 
				   AND cap.task_id = GISMO.task_id and cap.user_id = GISMO.user_id AND week.date = GISMO.imputDate
				   AND cap.timeConsume <> GISMO.imputTime);
	
	-- Insert the new imputation
	INSERT INTO GISMO_IMPUTATION(task_id, user_id, imputDate, imputTime, detail, weekNumberId)
	SELECT cap.task_id, cap.user_id, week.date, cap.timeConsume, cap.comment, cap.weekId 
	FROM CAPITAL_IMPUTATION as cap, GISMO_WEEK_NUMBER as week 
	WHERE cap.weekId = week.id and cap.error is null and cap.task_id is not null
	AND NOT EXISTS (SELECT GISMO.id FROM GISMO_IMPUTATION as GISMO 
	                WHERE GISMO.task_id = cap.task_id AND GISMO.user_id = cap.user_id AND GISMO.imputDate = week.date);

END$$


DELIMITER ;
