
DELIMITER $$

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
