
-- --------------------------------------------------------

--
-- Structure de la vue GISMO_TIME_WEEK
--
DROP TABLE IF EXISTS `GISMO_TIME_WEEK`;

CREATE ALGORITHM=UNDEFINED DEFINER=id4490645_lbarre@`%` SQL SECURITY DEFINER VIEW GISMO_TIME_WEEK  AS  select imp.user_id AS user_id,gUser.`name` AS `name`,`week`.dateYear AS dateYear,`week`.dateWeek AS dateWeek,sum(imp.imputTime) AS SUM_TIME from ((GISMO_IMPUTATION imp join WEEK_NUMBER `week`) join GISMO_USER gUser) where ((imp.weekNumberId = `week`.`id`) and (gUser.`id` = imp.user_id)) group by imp.user_id,`week`.dateYear,`week`.dateWeek having (sum(imp.imputTime) > 40) ;
