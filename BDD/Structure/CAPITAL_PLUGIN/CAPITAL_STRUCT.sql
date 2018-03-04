
--
-- Structure de la table CAPITAL_OS
--

DROP TABLE IF EXISTS CAPITAL_OS;
CREATE TABLE CAPITAL_OS (
  id int(11) NOT NULL,
  ident varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  name varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  project_id int(11) NOT NULL,
  version_id int(11) NOT NULL,
  export BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Structure de la table CAPITAL_ITEM
--

DROP TABLE IF EXISTS CAPITAL_ITEM;
CREATE TABLE CAPITAL_ITEM (
  id int(11) NOT NULL,
  name varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  subProject_name varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Structure de la table CAPITAL_SUBTYPE
--

DROP TABLE IF EXISTS CAPITAL_SUBTYPE;
CREATE TABLE CAPITAL_SUBTYPE (
  id int(11) NOT NULL,
  capitalSubType varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  capitalItem varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  project_id int(11) NOT NULL,
  task_type_id int(11) NOT NULL,
  export BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  version_id int(11) NOT NULL,
  sub_project_id int(11) DEFAULT NULL,
  task_type_id int(11) DEFAULT NULL,
  task_id int(11) DEFAULT NULL,
  warning varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  error varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Index pour la table CAPITAL_IMPUTATION
--
ALTER TABLE CAPITAL_IMPUTATION
  ADD PRIMARY KEY (id),
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- Index pour la table CAPITAL_ITEM
--
ALTER TABLE CAPITAL_ITEM
  ADD PRIMARY KEY (id),
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- Index pour la table CAPITAL_OS
--
ALTER TABLE CAPITAL_OS
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY ident (ident),
  ADD UNIQUE KEY name (name),
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- Index pour la table CAPITAL_SUBTYPE
--
ALTER TABLE CAPITAL_SUBTYPE
  ADD PRIMARY KEY (id),
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

