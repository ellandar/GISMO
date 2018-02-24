-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le :  sam. 24 fév. 2018 à 17:00
-- Version du serveur :  10.1.31-MariaDB
-- Version de PHP :  7.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `id4490645_gismo`
--

-- --------------------------------------------------------
CREATE ALGORITHM = UNDEFINED VIEW `GISMO_EXP_VERS_VIEW` AS 
SELECT year(imp.imputDate) as year, month(imp.imputDate) as month, grp.name as proj_group, proj.name as proj, vers.name as version, SUM(imp.imputTime) as timeConsumed 
FROM GISMO_IMPUTATION as imp, GISMO_VERSION as vers, GISMO_PROJECT as proj, GISMO_PROJECT_GROUP as grp, GISMO_TASK as task 
WHERE vers.project_id = proj.id AND proj.project_group_id = grp.id AND task.version_id = vers.id AND task.id = imp.task_id 
group by year(imp.imputDate), month(imp.imputDate), grp.name, proj.name, vers.name;

CREATE VIEW `GISMO_EXP_VERS_TYPE_VIEW` AS 
SELECT year(imp.imputDate) as year, month(imp.imputDate) as month, 
		 grp.name as proj_group, proj.name as proj, vers.name as version, tType.type, 
		 SUM(imp.imputTime) as timeConsumed 
FROM GISMO_IMPUTATION as imp, GISMO_VERSION as vers, GISMO_PROJECT as proj, GISMO_PROJECT_GROUP as grp, GISMO_TASK as task, GISMO_TASK_TYPE as tType 
WHERE vers.project_id = proj.id AND proj.project_group_id = grp.id AND task.version_id = vers.id AND task.id = imp.task_id AND tType.id = task.task_type_id 
group by year(imp.imputDate), month(imp.imputDate), grp.name, proj.name, vers.name, tType.type;

CREATE VIEW `GISMO_EXP_TYPE_VIEW` AS 
SELECT year(imp.imputDate) as year, month(imp.imputDate) as month, 
		 grp.name as proj_group, proj.name as proj, tType.type, 
		 SUM(imp.imputTime) as timeConsumed 
FROM GISMO_IMPUTATION as imp, GISMO_VERSION as vers, GISMO_PROJECT as proj, GISMO_PROJECT_GROUP as grp, GISMO_TASK as task, GISMO_TASK_TYPE as tType 
WHERE vers.project_id = proj.id AND proj.project_group_id = grp.id AND task.version_id = vers.id AND task.id = imp.task_id AND tType.id = task.task_type_id 
group by year(imp.imputDate), month(imp.imputDate), grp.name, proj.name, tType.type;

CREATE VIEW `GISMO_EXP_TASK_TYPE_VIEW` AS 
SELECT year(imp.imputDate) as year, month(imp.imputDate) as month, 
		 grp.name as proj_group, proj.name as proj, tType.name, 
		 SUM(imp.imputTime) as timeConsumed 
FROM GISMO_IMPUTATION as imp, GISMO_VERSION as vers, GISMO_PROJECT as proj, GISMO_PROJECT_GROUP as grp, GISMO_TASK as task, GISMO_TASK_TYPE as tType 
WHERE vers.project_id = proj.id AND proj.project_group_id = grp.id AND task.version_id = vers.id AND task.id = imp.task_id AND tType.id = task.task_type_id 
group by year(imp.imputDate), month(imp.imputDate), grp.name, proj.name, tType.name;


CREATE VIEW `GISMO_EXP_AVG_TYPE_VIEW` AS 
SELECT year, month, proj_group, proj, type,
timeConsumed / (SELECT SUM(tot.timeConsumed) FROM GISMO_EXP_TYPE_VIEW as tot 
            WHERE tot.year = vExp.year AND tot.month = vExp.month 
            AND tot.proj_group = vExp.proj_group AND tot.proj = vExp.proj 
            AND tot.type = vExp.type
            GROUP BY tot.year, tot.month, tot.proj_group, tot.proj)
FROM GISMO_EXP_TYPE_VIEW as vExp;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
