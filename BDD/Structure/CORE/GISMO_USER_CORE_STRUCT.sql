
-- --------------------------------------------------------

DROP VIEW IF EXISTS `GISMO_PROF_VIEW`;
DROP TABLE IF EXISTS GISMO_PROFIL;
DROP TABLE IF EXISTS GISMO_USER;

--
-- Structure de la table `GISMO_USER`
--

CREATE TABLE `GISMO_USER` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `trigramme` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `CAPITAL_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `JIRA_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Structure de la table `GISMO_PROFIL`
--

CREATE TABLE `GISMO_PROFIL` (
  `id` int(11) NOT NULL,
  `type` enum('USER','ADMIN','CDP','') COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `project_group_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Index pour la table `GISMO_USER`
--
ALTER TABLE `GISMO_USER`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trigramme` (`trigramme`),
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

  
--
-- Index pour la table `GISMO_PROFIL`
--
ALTER TABLE `GISMO_PROFIL`
  ADD PRIMARY KEY (`id`),
  ADD KEY `PROFIL_ibfk_1` (`project_group_id`),
  ADD KEY `PROFIL_ibfk_2` (`user_id`),
  ADD KEY `project_id` (`project_id`),
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1,
  ADD CONSTRAINT `GISMO_PROFIL_ibfk_1` FOREIGN KEY (`project_group_id`) REFERENCES `GISMO_PROJECT_GROUP` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_PROFIL_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `GISMO_USER` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_PROFIL_ibfk_3` FOREIGN KEY (`project_id`) REFERENCES `GISMO_PROJECT` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

  
  
CREATE VIEW `GISMO_PROF_VIEW`
 AS SELECT gUser.id as gismo_user_id, gUser.name as gismo_user_name, prof.type as gismo_profil, '' as obj_id, '' as obj_name
FROM GISMO_USER as gUser, GISMO_PROFIL as prof
WHERE gUser.id = prof.user_id AND prof.project_group_id is null AND prof.project_id is null 
UNION
SELECT gUser.id as gismo_user_id, gUser.name as gismo_user_name, prof.type as gismo_profil, grp.id, grp.name
FROM GISMO_USER as gUser, GISMO_PROFIL as prof, GISMO_PROJECT_GROUP as grp
WHERE gUser.id = prof.user_id AND prof.project_group_id = grp.id AND prof.project_id is null 
UNION
SELECT gUser.id as gismo_user_id, gUser.name as gismo_user_name, prof.type as gismo_profil, proj.id, proj.name
FROM GISMO_USER as gUser, GISMO_PROFIL as prof, GISMO_PROJECT as proj
WHERE gUser.id = prof.user_id AND prof.project_group_id is null AND prof.project_id = proj.id;
