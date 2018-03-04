

--
-- Base de données :  `id4490645_gismo`
--

DROP VIEW IF EXISTS `CAPITAL_PARAM_VIEW`;
CREATE VIEW `CAPITAL_PARAM_VIEW`
 AS SELECT 
 proj.id as gismo_proj_id,  proj.name as gismo_proj_name,
 vers.id as gismo_vers_id,  vers.name as gismo_vers_name,
 subP.id as gismo_subP_id,  subP.name as gismo_subP_name,
 tType.id as gismo_tType_id,  tType.name as gismo_tType_name,
 capOs.id as cap_OS_Id, capOs.name as cap_OS_name, 
 capSub.id as cap_SType_id, capSub.capitalSubType as cap_SType, 
 capItem.id as cap_item_id, capItem.name as cap_item
FROM 
GISMO_TASK_TYPE as tType,
GISMO_PROJECT as proj, 
GISMO_VERSION as vers,
GISMO_SUB_PROJECT as subP, 
CAPITAL_SUBTYPE as capSub, CAPITAL_ITEM as capItem, CAPITAL_OS as capOs
WHERE  tType.project_id = proj.id AND proj.id = vers.project_id AND proj.id = subP.project_id AND capOs.export = true
AND capSub.task_type_id = tType.id AND capItem.subProject_name = subP.name AND capOs.project_id = proj.id AND capOs.version_id = vers.id  AND capSub.export = true;


DROP VIEW IF EXISTS `CAPITAL_EXP_VIEW`;
CREATE VIEW `CAPITAL_EXP_VIEW`
 AS SELECT distinct year(imp.imputDate) as year, month(imp.imputDate) as month, week(imp.imputDate) as week, weekday(imp.imputDate) as weekday, 
 gUser.CAPITAL_name as user, capOs.name as OS, imp.imputTime as hour, capSub.capitalSubType as SubType, capItem.name as item, task.external_id as pcr, imp.detail as comment, '' as phase
FROM GISMO_USER as gUser, 
GISMO_IMPUTATION as imp,
GISMO_TASK as task, 
GISMO_TASK_TYPE as tType,
GISMO_PROJECT as proj, 
GISMO_VERSION as vers,
GISMO_SUB_PROJECT as subP, 
CAPITAL_SUBTYPE as capSub, 
CAPITAL_ITEM as capItem, 
CAPITAL_OS as capOs
WHERE gUser.id = imp.user_id AND imp.task_id = task.id AND task.task_type_id = tType.id AND tType.project_id = proj.id 
AND task.version_id = vers.id AND task.project_Id = proj.id AND task.sub_project_id = subP.id
AND capSub.task_type_id = tType.id AND capItem.subProject_name = subP.name AND capOs.project_id = proj.id
 AND capOs.version_id = vers.id AND capSub.export = true AND capOs.export = true;

DROP VIEW IF EXISTS CAPITAL_EXP_OS_VIEW;
CREATE VIEW CAPITAL_EXP_OS_VIEW
 AS SELECT vCapExp.year, vCapExp.month, vCapExp.OS, SUM(vCapExp.hour) as hours, SUM(vCapExp.hour)/8 as days FROM CAPITAL_EXP_VIEW vCapExp 
 GROUP BY vCapExp.year, vCapExp.month, vCapExp.OS;
 
 
 
DROP VIEW IF EXISTS `CAPITAL_EXP_OS_TYPE_VIEW`;
CREATE VIEW `CAPITAL_EXP_OS_TYPE_VIEW`
 AS SELECT year(imp.imputDate) as year, month(imp.imputDate) as month, capOs.name as OS, tType.type as type,
 SUM(imp.imputTime) as hours, SUM(imp.imputTime)/8 as days
FROM 
GISMO_IMPUTATION as imp,
GISMO_TASK as task, 
GISMO_TASK_TYPE as tType,
GISMO_PROJECT as proj, 
GISMO_VERSION as vers,
GISMO_SUB_PROJECT as subP, 
CAPITAL_SUBTYPE as capSub, 
CAPITAL_ITEM as capItem, 
CAPITAL_OS as capOs
WHERE imp.task_id = task.id AND task.task_type_id = tType.id AND tType.project_id = proj.id 
AND task.version_id = vers.id AND task.project_Id = proj.id AND task.sub_project_id = subP.id
AND capSub.task_type_id = tType.id AND capItem.subProject_name = subP.name AND capOs.project_id = proj.id 
AND capOs.version_id = vers.id AND capSub.export = true AND capOs.export = true
GROUP BY year(imp.imputDate), month(imp.imputDate), capOs.name, tType.type;

