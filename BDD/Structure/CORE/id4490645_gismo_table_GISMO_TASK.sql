
-- --------------------------------------------------------

--
-- Structure de la table `GISMO_TASK`
--

CREATE TABLE `GISMO_TASK` (
  `id` int(11) NOT NULL,
  `external_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'JIRA id',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `task_type_id` int(11) DEFAULT NULL,
  `level` enum('Simple','Complexe') COLLATE utf8_unicode_ci DEFAULT NULL,
  `project_Id` int(11) NOT NULL,
  `version_id` int(11) NOT NULL,
  `sub_project_id` int(11) DEFAULT NULL,
  `sub_version_Id` int(11) DEFAULT NULL,
  `state` enum('OPEN','IN_PROGRESS','DELIVERED','CLOSED') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'OPEN',
  `closureDate` date DEFAULT NULL,
  `consumedTime` int(11) DEFAULT NULL,
  `previewTime` int(11) DEFAULT NULL,
  `remainTime` int(11) DEFAULT NULL,
  `isGuarantee` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
