
-- --------------------------------------------------------

--
-- Structure de la table `JIRA_STATES`
--

DROP TABLE IF EXISTS JIRA_STATES;
CREATE TABLE JIRA_STATES (
  id int(11) NOT NULL AUTO_INCREMENT,
  gismo_state varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  jira_state varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS JIRA_TASK_TYPE;
CREATE TABLE JIRA_TASK_TYPE (
  id int(11) NOT NULL,
  issueType varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  component varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  task_type_id int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS JIRA_TASK;
CREATE TABLE JIRA_TASK (
  id int(11) NOT NULL,
  projectName varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  ident varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  issueType varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  summary varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  status varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  components varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  linkedIssue varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  affVersion varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  targetVersion varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  deliveryVersion varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  closureDate date DEFAULT NULL,
  project_id int(11) DEFAULT NULL,
  version_id int(11) DEFAULT NULL,
  sub_project_id int(11) DEFAULT NULL,
  sub_version_id int(11) DEFAULT NULL,
  task_type_id int(11) DEFAULT NULL,
  task_id int(11) DEFAULT NULL,
  state varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  warning varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  error varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Index pour les tables déchargées
--

ALTER TABLE JIRA_TASK
  ADD PRIMARY KEY (id),
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE JIRA_TASK_TYPE
  ADD PRIMARY KEY (id),
  ADD KEY task_type_id (task_type_id),
  MODIFY id int(11) NOT NULL AUTO_INCREMENT,
  ADD CONSTRAINT JIRA_TASK_TYPE_ibfk_1 FOREIGN KEY (task_type_id) REFERENCES GISMO_TASK_TYPE (id) ON DELETE SET NULL ON UPDATE NO ACTION;

ALTER TABLE JIRA_STATES
  ADD PRIMARY KEY (id),
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;