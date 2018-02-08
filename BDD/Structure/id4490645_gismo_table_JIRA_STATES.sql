
-- --------------------------------------------------------

--
-- Structure de la table JIRA_STATES
--

DROP TABLE IF EXISTS JIRA_STATES;
CREATE TABLE JIRA_STATES (
  id int(11) NOT NULL,
  gismo_state varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  jira_state varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
