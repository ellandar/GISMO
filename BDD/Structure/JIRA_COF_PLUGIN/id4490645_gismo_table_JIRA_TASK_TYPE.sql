
-- --------------------------------------------------------

--
-- Structure de la table `JIRA_TASK_TYPE`
--

CREATE TABLE `JIRA_TASK_TYPE` (
  `id` int(11) NOT NULL,
  `issueType` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `component` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `task_type_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
