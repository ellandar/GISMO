
-- --------------------------------------------------------


DROP VIEW IF EXISTS GISMO_TIME_WEEK;
DROP VIEW IF EXISTS GISMO_TIME_SUM;
DROP VIEW IF EXISTS GISMO_TIME_DAY;
DROP VIEW IF EXISTS GISMO_IMP;

DROP TABLE IF EXISTS GISMO_IMPUTATION;
--
-- Structure de la table `GISMO_IMPUTATION`
--

CREATE TABLE `GISMO_IMPUTATION` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `imputDate` date NOT NULL,
  `imputTime` int(11) NOT NULL,
  `detail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `weekNumberId` int(11) NOT NULL,
  `warning` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `error` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Index pour la table `GISMO_IMPUTATION`
--
ALTER TABLE `GISMO_IMPUTATION`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_id` (`task_id`),
  ADD KEY `user_id` (`user_id`),
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,
  ADD CONSTRAINT `GISMO_IMPUTATION_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `GISMO_TASK` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_IMPUTATION_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `GISMO_USER` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;


CREATE VIEW GISMO_TIME_WEEK  AS  
select imp.user_id AS user_id,gUser.`name` AS `name`,`week`.dateYear AS dateYear,`week`.dateWeek AS dateWeek,sum(imp.imputTime) AS SUM_TIME
from ((GISMO_IMPUTATION imp join GISMO_WEEK_NUMBER `week`) join GISMO_USER gUser) 
where ((imp.weekNumberId = `week`.`id`) and (gUser.`id` = imp.user_id))
group by imp.user_id,`week`.dateYear,`week`.dateWeek
having (sum(imp.imputTime) > 40) ;

CREATE VIEW GISMO_TIME_SUM  AS  
select imp.user_id AS user_id,`week`.dateYear AS dateYear,`week`.dateWeek AS dateWeek,`week`.dateDay AS dateDay,sum(imp.imputTime) AS SUM_TIME,'W1 - time of day > 8h' AS message 
from (GISMO_IMPUTATION imp join GISMO_WEEK_NUMBER `week`) 
where (imp.weekNumberId = `week`.`id`) 
group by imp.user_id,`week`.dateYear,`week`.dateWeek,`week`.dateDay 
having (sum(imp.imputTime) > 8) 
union 
select imp.user_id AS user_id,`week`.dateYear AS dateYear,`week`.dateWeek AS dateWeek,'' AS dateDay,sum(imp.imputTime) AS SUM_TIME,'W2 - time of week > 40h' AS message 
from (GISMO_IMPUTATION imp join GISMO_WEEK_NUMBER `week`) 
where (imp.weekNumberId = `week`.`id`) 
group by imp.user_id,`week`.dateYear,`week`.dateWeek 
having (sum(imp.imputTime) > 40) ;


CREATE VIEW GISMO_TIME_DAY  AS  select imp.user_id AS user_id,gUser.`name` AS `name`,imp.imputDate AS dayDate,sum(imp.imputTime) AS SUM_TIME from ((GISMO_IMPUTATION imp join GISMO_WEEK_NUMBER `week`) join GISMO_USER gUser)
 where ((imp.weekNumberId = `week`.`id`) and (gUser.`id` = imp.user_id)) 
 group by imp.user_id,`week`.dateYear,`week`.dateWeek,`week`.dateDay 
 having (sum(imp.imputTime) > 8) ;

 CREATE VIEW GISMO_IMP AS SELECT
    imp.user_id,
    gUser.name as 'user_name',
    imp.imputDate,
    imp.imputTime,
    task.external_id,
    task.project_Id,
    proj.name as 'proj_name',
    task.version_id,
    vers.name as 'vers_name',
    task.sub_project_id,
    subP.name as 'sub_proj_name',
    task.task_type_id,
    tType.name as 'type_name'
FROM
    GISMO_IMPUTATION imp,
    GISMO_TASK task,
    GISMO_PROJECT proj,
    GISMO_VERSION vers,
    GISMO_SUB_PROJECT subP,
    GISMO_TASK_TYPE tType,
    GISMO_USER gUser
WHERE
    imp.task_id = task.id AND task.project_Id = proj.id 
    AND vers.id = task.version_id AND subP.id = task.sub_project_id 
    AND tType.id = task.task_type_id AND gUser.id = imp.user_id
  
DELIMITER $$

DROP PROCEDURE IF EXISTS GISMO_CHECK_1$$
CREATE PROCEDURE GISMO_CHECK_1 ()  NO SQL
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
