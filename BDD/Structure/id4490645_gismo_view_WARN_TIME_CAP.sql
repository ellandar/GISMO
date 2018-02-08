
-- --------------------------------------------------------

--
-- Structure de la vue WARN_TIME_CAP
--
DROP TABLE IF EXISTS `WARN_TIME_CAP`;

CREATE ALGORITHM=UNDEFINED DEFINER=id4490645_lbarre@`%` SQL SECURITY DEFINER VIEW WARN_TIME_CAP  AS  select cap.userName AS userName,cap.dateYear AS dateYear,cap.dateWeek AS dateWeek,cap.dateDay AS dateDay,sum(cap.timeConsume) AS SUM_TIME,'W1 - time of day > 8h' AS warnMessage from CAPITAL_IMPUTATION cap group by cap.userName,cap.dateYear,cap.dateWeek,cap.dateDay having (sum(cap.timeConsume) > 8) union select cap.userName AS userName,cap.dateYear AS dateYear,cap.dateWeek AS dateWeek,'' AS Name_exp_4,sum(cap.timeConsume) AS SUM_TIME,'W2 - time of week > 40h' AS `W2 - time of week > 40h` from CAPITAL_IMPUTATION cap group by cap.userName,cap.dateYear,cap.dateWeek having (sum(cap.timeConsume) > 40) ;
