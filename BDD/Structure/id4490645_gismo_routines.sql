
DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS CAPITAL_1_IMPORT$$
CREATE DEFINER=id4490645_lbarre@% PROCEDURE CAPITAL_1_IMPORT ()  BEGIN
   
UPDATE CAPITAL_IMPUTATION SET user_id=(SELECT DISTINCT id FROM GISMO_USER WHERE GISMO_USER.CAPITAL_name=CAPITAL_IMPUTATION.userName);

UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.capitalOSId=(SELECT DISTINCT id FROM CAPITAL_OS WHERE CAPITAL_OS.name=CAPITAL_IMPUTATION.osName);

UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.weekId=(SELECT DISTINCT id FROM GISMO_WEEK_NUMBER WHERE GISMO_WEEK_NUMBER.dateYear=CAPITAL_IMPUTATION.dateYear AND GISMO_WEEK_NUMBER.dateWeek=CAPITAL_IMPUTATION.dateWeek AND GISMO_WEEK_NUMBER.dateDay=CAPITAL_IMPUTATION.dateDay);

UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.project_id = (SELECT DISTINCT CAPITAL_OS.project_id FROM CAPITAL_OS WHERE CAPITAL_OS.id = CAPITAL_IMPUTATION.capitalOSId);

UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.sub_project_id = (SELECT DISTINCT GISMO_SUB_PROJECT.id FROM GISMO_SUB_PROJECT , CAPITAL_ITEM WHERE GISMO_SUB_PROJECT.project_id = CAPITAL_IMPUTATION.project_id AND CAPITAL_IMPUTATION.item = CAPITAL_ITEM.name AND GISMO_SUB_PROJECT.name = CAPITAL_ITEM.subProject_name) ;

UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.task_type_id = (SELECT DISTINCT CAPITAL_SUBTYPE.task_type_id FROM CAPITAL_SUBTYPE WHERE CAPITAL_SUBTYPE.capitalSubType = CAPITAL_IMPUTATION.subType AND CAPITAL_SUBTYPE.capitalItem = CAPITAL_IMPUTATION.item AND CAPITAL_SUBTYPE.project_id = CAPITAL_IMPUTATION.project_id);


UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.error = 'E1 - No user (change configuration) ' WHERE CAPITAL_IMPUTATION.user_id is null and CAPITAL_IMPUTATION.error is null;

UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.error = 'E2 - No project (check OS configuration) ' WHERE CAPITAL_IMPUTATION.capitalOSId is null and CAPITAL_IMPUTATION.error is null;

UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.error = 'E3 - No sub project (check ITEM configuration) ' WHERE CAPITAL_IMPUTATION.sub_project_id is null and CAPITAL_IMPUTATION.error is null;

UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.error = 'E4 - No task type (check SUBTYPE configuration) ' WHERE CAPITAL_IMPUTATION.task_type_id is null and CAPITAL_IMPUTATION.error is null;

UPDATE CAPITAL_IMPUTATION SET CAPITAL_IMPUTATION.error = ' E5 - No week recognize (check WEEK/DATE configuration) ' WHERE CAPITAL_IMPUTATION.weekId is null and CAPITAL_IMPUTATION.error is null;

UPDATE CAPITAL_IMPUTATION as cap SET cap.warning = 'W0 - work on weekend' WHERE cap.dateDay in ('SUNDAY', 'SATRUDAY') and cap.error is null;

UPDATE CAPITAL_IMPUTATION as cap SET cap.error = (SELECT warn.warnMessage FROM WARN_TIME_CAP as warn WHERE warn.userName = cap.userName and warn.dateYear = cap.dateYear and warn.dateWeek=cap.dateWeek and warn.dateDay = cap.dateDay) and cap.error is null and cap.warning is null;

END$$

DROP PROCEDURE IF EXISTS CAPITAL_2_IMPORT$$
CREATE DEFINER=id4490645_lbarre@% PROCEDURE CAPITAL_2_IMPORT ()  NO SQL
BEGIN

-- TREAT the imputation with complements (get the task_id)

-- CREATE the missing task 
INSERT INTO GISMO_TASK(external_id, task_type_id, project_Id, sub_project_id, state) 
SELECT CAPITAL_IMPUTATION.complement, CAPITAL_IMPUTATION.task_type_id, CAPITAL_IMPUTATION.project_id, CAPITAL_IMPUTATION.sub_project_id, 'IN_PROGRESS'
FROM CAPITAL_IMPUTATION 
WHERE CAPITAL_IMPUTATION.complement is not null AND CAPITAL_IMPUTATION.complement != ''
AND CAPITAL_IMPUTATION.warning is null AND CAPITAL_IMPUTATION.error is null 
AND CAPITAL_IMPUTATION.task_id is null 
AND CAPITAL_IMPUTATION.complement not in (SELECT DISTINCT external_id FROM GISMO_TASK);
-- UPDATE the task_id
UPDATE CAPITAL_IMPUTATION SET task_id = (SELECT distinct id FROM GISMO_TASK WHERE GISMO_TASK.external_id = CAPITAL_IMPUTATION.complement AND GISMO_TASK.external_id != '') WHERE CAPITAL_IMPUTATION.complement is not null AND CAPITAL_IMPUTATION.complement != '';

-- TREAT the imputation without complements and with comments (get the task_id)
-- CREATE the missing task 
INSERT INTO GISMO_TASK(external_id, name, task_type_id, project_Id, sub_project_id, state) 
SELECT CONCAT('CAPITAL_'  + CAPITAL_IMPUTATION.comment), CAPITAL_IMPUTATION.comment, CAPITAL_IMPUTATION.task_type_id, CAPITAL_IMPUTATION.project_id, CAPITAL_IMPUTATION.sub_project_id, 'IN_PROGRESS'
FROM CAPITAL_IMPUTATION 
WHERE CAPITAL_IMPUTATION.comment is not null AND CAPITAL_IMPUTATION.comment != ''
AND CAPITAL_IMPUTATION.warning is null AND CAPITAL_IMPUTATION.error is null 
AND CAPITAL_IMPUTATION.task_id is null 
AND CONCAT('CAPITAL_'  + CAPITAL_IMPUTATION.comment) not in (SELECT DISTINCT external_id FROM GISMO_TASK);
-- UPDATE the task_id
UPDATE CAPITAL_IMPUTATION SET task_id = (SELECT distinct id FROM GISMO_TASK WHERE GISMO_TASK.external_id like CONCAT('CAPITAL_'  + CAPITAL_IMPUTATION.comment) AND GISMO_TASK.external_id != '') WHERE CAPITAL_IMPUTATION.comment is not null AND CAPITAL_IMPUTATION.comment != '' 
AND (CAPITAL_IMPUTATION.task_id is null OR CAPITAL_IMPUTATION.task_id = '') ;
  
-- import in GISMO_IMPUTATION
INSERT INTO GISMO_IMPUTATION(task_id, user_id, imputDate, imputTime, detail, weekNumberId)
SELECT cap.task_id, cap.user_id, week.date, cap.timeConsume, cap.comment, cap.weekId FROM CAPITAL_IMPUTATION as cap, GISMO_WEEK_NUMBER as week WHERE cap.weekId = week.id and cap.error is null and cap.task_id is not null;

END$$


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

DROP PROCEDURE IF EXISTS JIRA_1_IMPORT$$
CREATE DEFINER=id4490645_lbarre@% PROCEDURE JIRA_1_IMPORT ()  BEGIN
   
-- -----------------------------------------------------------------------------------------------------------------------------
-- FILLING FIELDS 
-- -----------------------------------------------------------------------------------------------------------------------------

-- project_id 
UPDATE JIRA_TASK SET project_id=(SELECT DISTINCT id FROM PROJECT WHERE PROJECT.name=JIRA_TASK.projectName);

-- version_id 
UPDATE JIRA_TASK SET version_id=(SELECT DISTINCT id FROM VERSION WHERE VERSION.name=JIRA_TASK.targetVersion);
UPDATE JIRA_TASK SET version_id=(SELECT DISTINCT id FROM VERSION WHERE VERSION.name=JIRA_TASK.affVersion) WHERE version_id is null;

-- sub_project_id
UPDATE JIRA_TASK SET JIRA_TASK.sub_project_id=(SELECT DISTINCT id FROM GISMO_SUB_PROJECT WHERE GISMO_SUB_PROJECT.name=JIRA_TASK.components AND GISMO_SUB_PROJECT.project_id = JIRA_TASK.project_id) WHERE issueType in ('DCN','SCO','PCR');
UPDATE JIRA_TASK SET JIRA_TASK.sub_project_id=(SELECT DISTINCT id FROM GISMO_SUB_PROJECT WHERE GISMO_SUB_PROJECT.name='DEFAULT' AND GISMO_SUB_PROJECT.project_id = JIRA_TASK.project_id) WHERE sub_project_id is null;

-- sub_version_id
UPDATE JIRA_TASK SET JIRA_TASK.sub_version_id=(SELECT DISTINCT id FROM SUB_VERSION WHERE SUB_VERSION.sub_project_id=JIRA_TASK.sub_project_id AND SUB_VERSION.name=JIRA_TASK.deliveryVersion);

INSERT INTO SUB_VERSION (name, sub_project_id, version_id) 
SELECT DISTINCT deliveryVersion, sub_project_id, version_id
FROM JIRA_TASK WHERE deliveryVersion is not null AND sub_project_id is not null AND version_id is not null AND sub_version_id is null;

UPDATE JIRA_TASK SET JIRA_TASK.sub_version_id=(SELECT DISTINCT id FROM SUB_VERSION WHERE SUB_VERSION.sub_project_id=JIRA_TASK.sub_project_id AND SUB_VERSION.name=JIRA_TASK.deliveryVersion);

-- task_type_id
UPDATE JIRA_TASK SET JIRA_TASK.task_type_id = (SELECT distinct JIRA_TASK_TYPE.task_type_id FROM JIRA_TASK_TYPE WHERE JIRA_TASK_TYPE.issueType = JIRA_TASK.issueType AND JIRA_TASK_TYPE.component = JIRA_TASK.components) WHERE JIRA_TASK.task_type_id is null;

UPDATE JIRA_TASK SET JIRA_TASK.task_type_id = (SELECT distinct JIRA_TASK_TYPE.task_type_id FROM JIRA_TASK_TYPE WHERE JIRA_TASK_TYPE.issueType = JIRA_TASK.issueType AND JIRA_TASK_TYPE.component is null) WHERE JIRA_TASK.task_type_id is null;

-- task_id
UPDATE JIRA_TASK SET JIRA_TASK.task_id = (SELECT DISTINCT TASK.id FROM TASK WHERE TASK.external_id = JIRA_TASK.ident and JIRA_TASK.project_id = TASK.project_id);

-- state
UPDATE JIRA_TASK SET state = (SELECT distinct gismo_state FROM JIRA_STATES WHERE JIRA_STATES.jira_state = JIRA_TASK.status);


-- -----------------------------------------------------------------------------------------------------------------------------
-- CHECK FIELDS 
-- -----------------------------------------------------------------------------------------------------------------------------

-- error on project_id
UPDATE JIRA_TASK SET error = 'E1 - No project found - check project configuration' WHERE project_id is null;
-- error on version_id
UPDATE JIRA_TASK SET error = 'E2 - No version found - check version configuration' WHERE version_id is null;
-- error on state
UPDATE JIRA_TASK SET error = 'E3 - No status found - check status configuration' WHERE JIRA_TASK.state is null;

-- warning on sub_project_id
UPDATE JIRA_TASK SET warning = 'W1 - No sub project found - check component configuration' WHERE sub_project_id is null;

-- warning on task without type : to be filled
UPDATE JIRA_TASK SET warning = 'W2 - No task type found - need to be modify manually' WHERE task_type_id is null;


END$$

DROP PROCEDURE IF EXISTS JIRA_2_IMPORT$$
CREATE DEFINER=id4490645_lbarre@% PROCEDURE JIRA_2_IMPORT ()  BEGIN

-- import new task   
INSERT INTO GISMO_TASK(external_id, name, task_type_id, project_Id, version_id, sub_project_id, sub_version_Id, state) 
SELECT ident, summary, task_type_id, project_Id, version_id, sub_project_id, sub_version_id, state
FROM JIRA_TASK
WHERE JIRA_TASK.error is null AND JIRA_TASK.task_id is null;
  
-- update the older task (update limited to state and empty fields - task created from CAPITAL)
UPDATE GISMO_TASK SET state = 'OPEN' WHERE state != 'OPEN' AND id in (SELECT task_id FROM JIRA_TASK WHERE state = 'OPEN' AND error is null);
UPDATE GISMO_TASK SET state = 'IN_PROGRESS' WHERE state != 'IN_PROGRESS' AND id in (SELECT task_id FROM JIRA_TASK WHERE state = 'IN_PROGRESS' AND error is null);
UPDATE GISMO_TASK SET state = 'DELIVERED' WHERE state != 'DELIVERED' AND id in (SELECT task_id FROM JIRA_TASK WHERE state = 'DELIVERED' AND error is null);
UPDATE GISMO_TASK SET state = 'CLOSED' WHERE state != 'CLOSED' AND id in (SELECT task_id FROM JIRA_TASK WHERE state = 'CLOSED' AND error is null);

UPDATE GISMO_TASK SET name = (SELECT name FROM JIRA_TASK WHERE JIRA_TASK.task_id = GISMO_TASK.id) WHERE name is null;
UPDATE GISMO_TASK SET version_id = (SELECT version_id FROM JIRA_TASK WHERE JIRA_TASK.task_id = GISMO_TASK.id) WHERE version_id is null;
UPDATE GISMO_TASK SET sub_project_id = (SELECT sub_project_id FROM JIRA_TASK WHERE JIRA_TASK.task_id = GISMO_TASK.id) WHERE sub_project_id is null;
UPDATE GISMO_TASK SET sub_version_Id = (SELECT sub_version_Id FROM JIRA_TASK WHERE JIRA_TASK.task_id = GISMO_TASK.id) WHERE sub_version_Id is null;

END$$

DELIMITER ;
