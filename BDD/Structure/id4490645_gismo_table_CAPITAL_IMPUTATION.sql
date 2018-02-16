
-- --------------------------------------------------------

--
-- Structure de la table CAPITAL_IMPUTATION
--

DROP TABLE IF EXISTS CAPITAL_IMPUTATION;
CREATE TABLE CAPITAL_IMPUTATION (
  id int(11) NOT NULL,
  dateYear varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  dateWeek varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  dateDay varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  userName varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  osName varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  timeConsume int(11) NOT NULL,
  subType varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  osIdent varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  item varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  complement varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  comment varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  phase varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  weekId int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  capitalOSId int(11) DEFAULT NULL,
  project_id int(11) NOT NULL,
  sub_project_id int(11) DEFAULT NULL,
  task_type_id int(11) DEFAULT NULL,
  task_id int(11) DEFAULT NULL,
  warning varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  error varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
