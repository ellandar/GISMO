
-- --------------------------------------------------------

--
-- Structure de la table `JIRA_TASK`
--

CREATE TABLE `JIRA_TASK` (
  `id` int(11) NOT NULL,
  `projectName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ident` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `issueType` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `summary` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `severity` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `priority` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assignee` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reporter` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `components` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `linkedIssue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `affVersion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `targetVersion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deliveryVersion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `closureDate` date DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `version_id` int(11) DEFAULT NULL,
  `sub_project_id` int(11) DEFAULT NULL,
  `sub_version_id` int(11) DEFAULT NULL,
  `task_type_id` int(11) DEFAULT NULL,
  `task_id` int(11) DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `warning` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `error` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
