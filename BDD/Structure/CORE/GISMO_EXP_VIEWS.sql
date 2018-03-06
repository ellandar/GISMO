
DROP CREATE VIEW GISMO_EXP_PROJ_VIEW; 
DROP CREATE VIEW GISMO_EXP_VERS_VIEW; 
DROP CREATE VIEW GISMO_EXP_VERS_TYPE_VIEW; 
DROP VIEW GISMO_EXP_TYPE_VIEW;
DROP VIEW GISMO_EXP_TASK_TYPE_VIEW;
DROP VIEW GISMO_EXP_AVG_TYPE_VIEW;
	
-- --------------------------------------------------------
CREATE VIEW GISMO_EXP_PROJ_VIEW AS 
SELECT year(imp.imputDate) as year, month(imp.imputDate) as month, grp.name as proj_group, proj.name as proj, SUM(imp.imputTime) as timeConsumed 
FROM GISMO_IMPUTATION as imp, GISMO_PROJECT as proj, GISMO_PROJECT_GROUP as grp, GISMO_TASK as task 
WHERE proj.project_group_id = grp.id AND task.id = imp.task_id AND task.project_id = proj.id
group by year(imp.imputDate), month(imp.imputDate), grp.name, proj.name;

CREATE VIEW GISMO_EXP_VERS_VIEW AS 
SELECT year(imp.imputDate) as year, month(imp.imputDate) as month, grp.name as proj_group, proj.name as proj, vers.name as version, SUM(imp.imputTime) as timeConsumed 
FROM GISMO_IMPUTATION as imp, GISMO_VERSION as vers, GISMO_PROJECT as proj, GISMO_PROJECT_GROUP as grp, GISMO_TASK as task 
WHERE vers.project_id = proj.id AND proj.project_group_id = grp.id AND task.version_id = vers.id AND task.id = imp.task_id 
group by year(imp.imputDate), month(imp.imputDate), grp.name, proj.name, vers.name;

CREATE VIEW GISMO_EXP_VERS_TYPE_VIEW AS 
SELECT year(imp.imputDate) as year, month(imp.imputDate) as month, 
		 grp.name as proj_group, proj.name as proj, vers.name as version, tType.type, 
		 SUM(imp.imputTime) as timeConsumed 
FROM GISMO_IMPUTATION as imp, GISMO_VERSION as vers, GISMO_PROJECT as proj, GISMO_PROJECT_GROUP as grp, GISMO_TASK as task, GISMO_TASK_TYPE as tType 
WHERE vers.project_id = proj.id AND proj.project_group_id = grp.id AND task.version_id = vers.id AND task.id = imp.task_id AND tType.id = task.task_type_id 
group by year(imp.imputDate), month(imp.imputDate), grp.name, proj.name, vers.name, tType.type;

CREATE VIEW GISMO_EXP_TYPE_VIEW AS 
SELECT year(imp.imputDate) as year, month(imp.imputDate) as month, 
		 grp.name as proj_group, proj.name as proj, tType.type, 
		 SUM(imp.imputTime) as timeConsumed 
FROM GISMO_IMPUTATION as imp, GISMO_VERSION as vers, GISMO_PROJECT as proj, GISMO_PROJECT_GROUP as grp, GISMO_TASK as task, GISMO_TASK_TYPE as tType 
WHERE vers.project_id = proj.id AND proj.project_group_id = grp.id AND task.version_id = vers.id AND task.id = imp.task_id AND tType.id = task.task_type_id 
group by year(imp.imputDate), month(imp.imputDate), grp.name, proj.name, tType.type;

CREATE VIEW GISMO_EXP_TASK_TYPE_VIEW AS 
SELECT year(imp.imputDate) as year, month(imp.imputDate) as month, 
		 grp.name as proj_group, proj.name as proj, tType.name, 
		 SUM(imp.imputTime) as timeConsumed 
FROM GISMO_IMPUTATION as imp, GISMO_VERSION as vers, GISMO_PROJECT as proj, GISMO_PROJECT_GROUP as grp, GISMO_TASK as task, GISMO_TASK_TYPE as tType 
WHERE vers.project_id = proj.id AND proj.project_group_id = grp.id AND task.version_id = vers.id AND task.id = imp.task_id AND tType.id = task.task_type_id 
group by year(imp.imputDate), month(imp.imputDate), grp.name, proj.name, tType.name;

CREATE VIEW GISMO_EXP_AVG_TYPE_VIEW AS 
SELECT expType.year, expType.month, expType.proj_group, expType.proj, expType.type, expType.timeConsumed*100/expProj.timeConsumed as avg_time FROM
GISMO_EXP_TYPE_VIEW expType,
GISMO_EXP_PROJ_VIEW expProj
WHERE expType.year = expProj.year AND expType.month = expProj.month AND expType.proj = expProj.proj;

