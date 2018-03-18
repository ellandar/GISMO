
DELIMITER $$
--


DROP PROCEDURE IF EXISTS JIRA_0_IMPORT$$
CREATE  PROCEDURE JIRA_0_IMPORT ()  BEGIN
   
INSERT INTO JIRA_TASK (projectName, ident, issueType, summary, status, components, linkedIssue, affVersion, targetVersion, deliveryVersion)
select JIRA_TASK.projectName, ident, issueType, summary, status, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(JIRA_TASK.components, ',', numbers.n), ',', -1)) as name, linkedIssue, affVersion, targetVersion, deliveryVersion from (select 1 n union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9 union all select 10 union all select 11 union all select 12 union all select 13) numbers INNER JOIN JIRA_TASK on CHAR_LENGTH(JIRA_TASK.components) -CHAR_LENGTH(REPLACE(JIRA_TASK.components, ',', ''))>=numbers.n-1;

END$$
   
DROP PROCEDURE IF EXISTS JIRA_1_IMPORT$$
CREATE  PROCEDURE JIRA_1_IMPORT ()  BEGIN
   
   
UPDATE JIRA_TASK SET error = null, warning = null, project_id = null, version_id = null, sub_project_id = null, sub_version_id = null, task_id = null, task_type_id = null, state = null;

-- -----------------------------------------------------------------------------------------------------------------------------
-- FILLING FIELDS 
-- -----------------------------------------------------------------------------------------------------------------------------

-- project_id 
UPDATE JIRA_TASK SET project_id=(SELECT DISTINCT project_id FROM JIRA_PROJECT WHERE JIRA_PROJECT.project_name=JIRA_TASK.projectName);

-- version_id 
UPDATE JIRA_TASK SET version_id=(SELECT DISTINCT distinct gVers.id FROM GISMO_VERSION gVers, JIRA_VERSION jVers WHERE jVers.gismo_name=gVers.name  AND jVers.jira_name=JIRA_TASK.targetVersion);
UPDATE JIRA_TASK SET version_id=(SELECT DISTINCT distinct gVers.id FROM GISMO_VERSION gVers, JIRA_VERSION jVers WHERE jVers.gismo_name=gVers.name  AND jVers.jira_name=JIRA_TASK.affVersion) WHERE version_id is null;

-- sub_project_id
UPDATE JIRA_TASK SET JIRA_TASK.sub_project_id=(SELECT DISTINCT id FROM GISMO_SUB_PROJECT WHERE GISMO_SUB_PROJECT.name=JIRA_TASK.components AND GISMO_SUB_PROJECT.project_id = JIRA_TASK.project_id) ;
UPDATE JIRA_TASK SET JIRA_TASK.sub_project_id=(SELECT DISTINCT id FROM GISMO_SUB_PROJECT WHERE GISMO_SUB_PROJECT.name='DEFAULT' AND GISMO_SUB_PROJECT.project_id = JIRA_TASK.project_id) WHERE sub_project_id is null;

-- sub_version_id

INSERT INTO GISMO_SUB_VERSION (name, sub_project_id)
SELECT DISTINCT deliveryVersion, sub_project_id
FROM JIRA_TASK jTask WHERE (jTask.deliveryVersion, jTask.sub_project_id)
NOT IN(SELECT gSV.name,gSV.sub_project_id FROM GISMO_SUB_VERSION gSV)
AND deliveryVersion is not null;

UPDATE GISMO_SUB_VERSION gSV SET version_id = (SELECT version_id FROM JIRA_TASK jTask WHERE jTask.deliveryVersion = gSV.name AND jTask.sub_project_id = gSV.sub_project_id LIMIT 1) WHERE version_id is null OR version_id = 0;

UPDATE JIRA_TASK SET JIRA_TASK.sub_version_id=(SELECT DISTINCT id FROM GISMO_SUB_VERSION WHERE GISMO_SUB_VERSION.sub_project_id=JIRA_TASK.sub_project_id AND GISMO_SUB_VERSION.name=JIRA_TASK.deliveryVersion AND GISMO_SUB_VERSION.version_id = JIRA_TASK.version_id);

UPDATE JIRA_TASK SET JIRA_TASK.sub_version_id=(SELECT DISTINCT id FROM GISMO_SUB_VERSION WHERE GISMO_SUB_VERSION.sub_project_id=JIRA_TASK.sub_project_id AND GISMO_SUB_VERSION.name=JIRA_TASK.deliveryVersion) WHERE sub_version_id is null;

-- task_type_id
UPDATE JIRA_TASK SET JIRA_TASK.task_type_id = (SELECT distinct JIRA_TASK_TYPE.task_type_id FROM JIRA_TASK_TYPE WHERE JIRA_TASK_TYPE.issueType = JIRA_TASK.issueType AND JIRA_TASK_TYPE.component = JIRA_TASK.components AND JIRA_TASK_TYPE.project_id = JIRA_TASK.project_id) WHERE JIRA_TASK.task_type_id is null;

UPDATE JIRA_TASK SET JIRA_TASK.task_type_id = (SELECT distinct JIRA_TASK_TYPE.task_type_id FROM JIRA_TASK_TYPE WHERE JIRA_TASK_TYPE.issueType = JIRA_TASK.issueType AND JIRA_TASK_TYPE.component is null AND JIRA_TASK_TYPE.project_id = JIRA_TASK.project_id) WHERE JIRA_TASK.task_type_id is null;

-- task_id
UPDATE JIRA_TASK SET JIRA_TASK.task_id = (SELECT DISTINCT GISMO_TASK.id FROM GISMO_TASK WHERE GISMO_TASK.external_id = JIRA_TASK.ident and JIRA_TASK.sub_project_id = GISMO_TASK.sub_project_id);

-- state
UPDATE JIRA_TASK SET state = (SELECT distinct gismo_state FROM JIRA_STATES WHERE JIRA_STATES.jira_state = JIRA_TASK.status);


-- -----------------------------------------------------------------------------------------------------------------------------
-- CHECK FIELDS 
-- -----------------------------------------------------------------------------------------------------------------------------

-- error on project_id
UPDATE JIRA_TASK SET error = 'E1 - No project found - check project configuration' WHERE project_id is null and error is null;
-- error on version_id
UPDATE JIRA_TASK SET error = 'E2 - No version found - check version configuration' WHERE version_id is null and error is null;
-- error on state
UPDATE JIRA_TASK SET error = 'E3 - No status found - check status configuration' WHERE JIRA_TASK.state is null and error is null;

-- warning on sub_project_id
UPDATE JIRA_TASK SET warning = 'W1 - No sub project found - check component configuration' WHERE sub_project_id is null and error is null and warning is null;

-- warning on task without type : to be filled
UPDATE JIRA_TASK SET warning = 'W2 - No task type found - need to be modify manually' WHERE task_type_id is null and error is null and warning is null;


END$$

DROP PROCEDURE IF EXISTS JIRA_2_IMPORT$$
CREATE  PROCEDURE JIRA_2_IMPORT ()  BEGIN

-- import new task   
INSERT INTO GISMO_TASK(external_id, name, task_type_id, project_Id, sub_project_id, sub_version_Id, state) 
SELECT ident, summary, task_type_id, project_Id, sub_project_id, sub_version_id, state
FROM JIRA_TASK
WHERE JIRA_TASK.error is null AND JIRA_TASK.task_id is null;
  
-- update the older task (update limited to state and empty fields - task created from CAPITAL)
UPDATE GISMO_TASK SET state = 'OPEN' WHERE state != 'OPEN' AND id in (SELECT task_id FROM JIRA_TASK WHERE state = 'OPEN' AND error is null);
UPDATE GISMO_TASK SET state = 'IN_PROGRESS' WHERE state != 'IN_PROGRESS' AND id in (SELECT task_id FROM JIRA_TASK WHERE state = 'IN_PROGRESS' AND error is null);
UPDATE GISMO_TASK SET state = 'DELIVERED' WHERE state != 'DELIVERED' AND id in (SELECT task_id FROM JIRA_TASK WHERE state = 'DELIVERED' AND error is null);
UPDATE GISMO_TASK SET state = 'CLOSED' WHERE state != 'CLOSED' AND id in (SELECT task_id FROM JIRA_TASK WHERE state = 'CLOSED' AND error is null);
UPDATE GISMO_TASK gTask SET closureDate = (SELECT closureDate FROM JIRA_TASK WHERE JIRA_TASK.task_id = gTask.id) WHERE state in ('DELIVERED', 'CLOSED');

UPDATE GISMO_TASK SET name = (SELECT name FROM JIRA_TASK WHERE JIRA_TASK.task_id = GISMO_TASK.id) WHERE name is null;
-- JIRA version is not precise yet 
-- UPDATE GISMO_TASK SET version_id = (SELECT version_id FROM JIRA_TASK WHERE JIRA_TASK.task_id = GISMO_TASK.id) WHERE version_id is null;
UPDATE GISMO_TASK SET sub_project_id = (SELECT sub_project_id FROM JIRA_TASK WHERE JIRA_TASK.task_id = GISMO_TASK.id) WHERE sub_project_id is null;
UPDATE GISMO_TASK SET sub_version_Id = (SELECT sub_version_Id FROM JIRA_TASK WHERE JIRA_TASK.task_id = GISMO_TASK.id) WHERE sub_version_Id is null;

END$$

DELIMITER ;
