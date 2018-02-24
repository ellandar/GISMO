
DELIMITER $$


DROP PROCEDURE IF EXISTS GISMO_CHECK_1$$
CREATE DEFINER=id4490645_lbarre@% PROCEDURE GISMO_CHECK_1 ()  NO SQL
BEGIN

-- more than 8h imputed by day by user => Error
UPDATE GISMO_IMPUTATION SET error = 'E6 - time of day > 8h' WHERE error is null 
AND id in (SELECT imp.id FROM GISMO_IMPUTATION imp, GISMO_TIME_DAY vTime WHERE vTime.user_id = imp.user_id AND vTime.dayDate = imp.imputDate);

-- more than 40h imputed by week by user => Error
UPDATE GISMO_IMPUTATION SET error = 'E7 - time of week > 40h' WHERE error is null 
AND id in (SELECT imp.id FROM GISMO_IMPUTATION imp, GISMO_TIME_WEEK vTime, GISMO_WEEK_NUMBER week
WHERE vTime.user_id = imp.user_id AND week.id = imp.weekNumberId
AND vTime.dateYear = week.dateYear AND vTime.dateWeek = week.dateWeek);

-- saturday or sunday imputed => warning
UPDATE GISMO_IMPUTATION SET warning='W1 - Week end worked' WHERE weekNumberId in (SELECT id FROM GISMO_WEEK_NUMBER WHERE dateDay in ('SUNDAY', 'SATURDAY'));

END$$

DELIMITER ;
