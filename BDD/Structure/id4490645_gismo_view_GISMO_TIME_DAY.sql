
-- --------------------------------------------------------

--
-- Structure de la vue GISMO_TIME_DAY
--
DROP TABLE IF EXISTS `GISMO_TIME_DAY`;

CREATE ALGORITHM=UNDEFINED DEFINER=id4490645_lbarre@`%` SQL SECURITY DEFINER VIEW GISMO_TIME_DAY  AS  select imp.user_id AS user_id,gUser.`name` AS `name`,imp.imputDate AS dayDate,sum(imp.imputTime) AS SUM_TIME from ((GISMO_IMPUTATION imp join WEEK_NUMBER `week`) join GISMO_USER gUser) where ((imp.weekNumberId = `week`.`id`) and (gUser.`id` = imp.user_id)) group by imp.user_id,`week`.dateYear,`week`.dateWeek,`week`.dateDay having (sum(imp.imputTime) > 8) ;
