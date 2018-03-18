
-- --------------------------------------------------------

--
-- Données de la table `JIRA_STATES`
--

DELETE FROM JIRA_STATES;
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Accepted','OPEN');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Analysed','IN_PROGRESS');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Analysis_Started','IN_PROGRESS');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Closed','CLOSED');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Disapproved','OPEN');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('In Progress','IN_PROGRESS');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('IRF Accepted','OPEN');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Open','OPEN');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Queried','OPEN');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Referred','OPEN');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Resolved','DELIVERED');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Solved','CLOSED');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Submitted','OPEN');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Verified','IN_PROGRESS');
INSERT INTO JIRA_STATES (jira_state, gismo_state) VALUES ('Waiting','IN_PROGRESS');

-- --------------------------------------------------------------------
-- Add new type for task to be defined 
 DELETE FROM GISMO_TASK_TYPE WHERE name = 'JIRA_TO_BE_DEFINED';
INSERT INTO GISMO_TASK_TYPE (name, type, project_id, default_task_id) SELECT 'JIRA_TO_BE_DEFINED','SUPPORT',id, NULL FROM GISMO_PROJECT WHERE name ='DEFAULT';
INSERT INTO GISMO_TASK_TYPE (name, type, project_id, default_task_id) SELECT 'JIRA_TO_BE_DEFINED','SUPPORT',id, NULL FROM GISMO_PROJECT WHERE name ='Coflight DEV';

-- --------------------------------------------------------------------

--
-- Données de la table `JIRA_TASK_TYPE`
--
DELETE FROM JIRA_TASK_TYPE;
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'SCO',null, id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'JIRA_TO_BE_DEFINED';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'PCR',null, id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'Supp - ANA';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'PR',null, id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'Supp - ANA';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'DCN',null, id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'SW-DOC';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'IRF',null, id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'Supp - ANA';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'TM SubTask',null, id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'JIRA_TO_BE_DEFINED';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'TM Task',null, id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'JIRA_TO_BE_DEFINED';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'SCO', 'COMW_ENV', id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'SW-PCR-JAVA';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'SCO', 'COMW_TECH', id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'SW-PCR-CPP';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'SCO', 'DPR', id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'SW-PCR-JAVA';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'SCO', 'ENV', id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'SW-PCR-JAVA';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'SCO', 'IOPM', id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'SW-PCR-JAVA';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'SCO', 'OHMI', id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'SW-PCR-JAVA';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'SCO', 'REC', id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'SW-PCR-CPP';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'SCO', 'THMI', id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'SW-PCR-JAVA';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'SCO', 'TLAY', id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'SW-PCR-CPP';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'SCO', 'TSUP', id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'SW-PCR-CPP';
INSERT INTO JIRA_TASK_TYPE(issueType, component, task_type_id, project_id) SELECT 'SCO', 'UTILS', id, project_id FROM GISMO_TASK_TYPE WHERE GISMO_TASK_TYPE.name = 'SW-PCR-JAVA';
-- --------------------------------------------------------------------

--
-- Données de la table `JIRA_PROJECT`
--
DELETE FROM JIRA_PROJECT;
INSERT INTO JIRA_PROJECT(project_name, project_id) SELECT 'CPR', id FROM GISMO_PROJECT WHERE GISMO_PROJECT.name = 'Coflight DEV';
INSERT INTO JIRA_PROJECT(project_name, project_id) SELECT 'COFLIGHT_DEV', id FROM GISMO_PROJECT WHERE GISMO_PROJECT.name = 'Coflight DEV';

DELETE FROM JIRA_VERSION;
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('8,6','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('008.003.003','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('008.006.001','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('008.006.004','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('8.3.6','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('8.6.2','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('8.6.3','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('8.6.5','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('a','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('COF V2','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V1','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V1, V2','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V1, V2 pre-req','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V1, V2, V3, V4','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V1.0','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V1.1FAT','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V1VAStep1','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V1VAStep1b','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V1VAStep2','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V1VAStep3','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2 demo2','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2 March 2013','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2 Mid-July','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2 Mid-October','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2 midVA100%','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2 midVA80%','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2 November 2012','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2 pre-req','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2, V3','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2, V3, V4','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2ECR','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2-IBB1','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2IBB2','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2-IBB2','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2-IBB3','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2-ImprovedVA','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2R1','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2R1 FAT','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2R1 Jan14','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2R1-IBB0','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2R1-IBB1','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2R1-IBB2','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2R1-IBB2-SM2.11.2','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2R1Va, V3','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2R1Va, V3, V4','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2R1Va, V3R1','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V2R2','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3 May15','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3 Nov15','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3, V3R1','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3, V4','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3_CONSO','V3Conso');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3_CONSO_DEC','V3Conso');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3_CONSO_FEB','V3Conso');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3_CONSO_JAN','V3Conso');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3_CONSO_JULY','V3Conso');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3_CONSO_MARCH','V3Conso');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3_CONSO_NOV','V3Conso');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3_CONSO_SEPT','V3Conso');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3ConsoMay','V3Conso');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3ConsoMay17','V3Conso');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3-IBB1','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3-IBB2','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3-IBB3','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3-Oct14','V3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3R1','V3R1');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3R1, V3R2','V3R2');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3R1_ANTICIPATED','V3R1');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3R1June17','V3R1');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3R2','V3R2');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3R2, V3ConsoMay17','V3R2');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3R2, V3-IBB3','V3R2');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3R2, V3R1June17','V3R2');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3R2, V3R1June17, V3ConsoMay17','V3R2');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3R2Dec17','V3R2');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3R3','V3R3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V3R3, V3R2Dec17, V3ConsoMay17','V3R3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('V4','V3R3');
INSERT INTO JIRA_VERSION(jira_name, gismo_name) VALUES ('Vx','V3R3');
