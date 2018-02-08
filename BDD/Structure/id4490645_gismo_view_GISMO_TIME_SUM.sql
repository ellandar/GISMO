
-- --------------------------------------------------------

--
-- Structure de la vue GISMO_TIME_SUM
--
DROP TABLE IF EXISTS `GISMO_TIME_SUM`;

CREATE ALGORITHM=UNDEFINED DEFINER=id4490645_lbarre@`%` SQL SECURITY DEFINER VIEW GISMO_TIME_SUM  AS  select imp.user_id AS user_id,`week`.dateYear AS dateYear,`week`.dateWeek AS dateWeek,`week`.dateDay AS dateDay,sum(imp.imputTime) AS SUM_TIME,'W1 - time of day > 8h' AS message from (GISMO_IMPUTATION imp join WEEK_NUMBER `week`) where (imp.weekNumberId = `week`.`id`) group by imp.user_id,`week`.dateYear,`week`.dateWeek,`week`.dateDay having (sum(imp.imputTime) > 8) union select imp.user_id AS user_id,`week`.dateYear AS dateYear,`week`.dateWeek AS dateWeek,'' AS dateDay,sum(imp.imputTime) AS SUM_TIME,'W2 - time of week > 40h' AS message from (GISMO_IMPUTATION imp join WEEK_NUMBER `week`) where (imp.weekNumberId = `week`.`id`) group by imp.user_id,`week`.dateYear,`week`.dateWeek having (sum(imp.imputTime) > 40) ;
