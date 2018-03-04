
-- --------------------------------------------------------

DROP TABLE IF EXISTS GISMO_TASK_LINK;
DROP TABLE IF EXISTS GISMO_TASK;
--
-- Structure de la table `GISMO_TASK`
--

CREATE TABLE `GISMO_TASK` (
  `id` int(11) NOT NULL,
  `external_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'JIRA id',
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

--
-- Structure de la table `GISMO_TASK_LINK`
--

CREATE TABLE `GISMO_TASK_LINK` (
  `child_task_id` int(11) NOT NULL,
  `parent_task_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Index pour la table `GISMO_TASK`
--
ALTER TABLE `GISMO_TASK`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_type_id` (`task_type_id`),
  ADD KEY `projectId` (`project_Id`),
  ADD KEY `subVersion_Id` (`sub_version_Id`),
  ADD KEY `version_id` (`version_id`),
  ADD KEY `TASK_ibfk_2` (`sub_project_id`),
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1,
  ADD CONSTRAINT `GISMO_TASK_ibfk_2` FOREIGN KEY (`sub_project_id`) REFERENCES `GISMO_SUB_PROJECT` (`id`) ON DELETE CASCADE UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_TASK_ibfk_3` FOREIGN KEY (`version_id`) REFERENCES `GISMO_VERSION` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_TASK_ibfk_4` FOREIGN KEY (`task_type_id`) REFERENCES `GISMO_TASK_TYPE` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_TASK_ibfk_5` FOREIGN KEY (`sub_version_Id`) REFERENCES `GISMO_SUB_VERSION` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_TASK_ibfk_6` FOREIGN KEY (`project_Id`) REFERENCES `GISMO_PROJECT` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Index pour la table `GISMO_TASK_LINK`
--
ALTER TABLE `GISMO_TASK_LINK`
  ADD PRIMARY KEY (`child_task_id`,`parent_task_id`),
  ADD KEY `child_task_id` (`child_task_id`),
  ADD KEY `parent_task_id` (`parent_task_id`),
  ADD CONSTRAINT `GISMO_TASK_LINK_ibfk_1` FOREIGN KEY (`parent_task_id`) REFERENCES `GISMO_TASK` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_TASK_LINK_ibfk_2` FOREIGN KEY (`child_task_id`) REFERENCES `GISMO_TASK` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;


