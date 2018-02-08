
-- --------------------------------------------------------

--
-- Structure de la table WARN_TIME_IMPUT
--

DROP TABLE IF EXISTS WARN_TIME_IMPUT;
CREATE ALGORITHM=UNDEFINED DEFINER=id4490645_lbarre@`%` SQL SECURITY DEFINER VIEW WARN_TIME_IMPUT  AS  select imp.user_id AS `user`,`week`.dateYear AS `year`,`week`.dateWeek AS `week`,`week`.`date` AS `day`,imp.imputDate AS `date`,sum(imp.imputTime) AS SUM_TIME,'E1 - time of day > 8h' AS warnMessage from (IMPUTATION imp join WEEK_NUMBER `week`) where (imp.weekNumberId = `week`.`id`) group by imp.user_id,`week`.dateYear,`week`.dateWeek,`week`.`date`,imp.imputDate having (sum(imp.imputTime) > 8) union select imp.user_id AS `user`,`week`.dateYear AS `year`,`week`.dateWeek AS `week`,`week`.`date` AS `day`,NULL AS `date`,sum(imp.imputTime) AS SUM_TIME,'E2 - time of week > 40h' AS warnMessage from (IMPUTATION imp join WEEK_NUMBER `week`) where (imp.weekNumberId = `week`.`id`) group by imp.user_id,`week`.dateYear,`week`.dateWeek,`week`.`date` having (sum(imp.imputTime) > 40) ;
