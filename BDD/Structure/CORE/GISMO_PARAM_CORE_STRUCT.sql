
-- --------------------------------------------------------

DROP VIEW IF EXISTS GISMO_PROJ;
DROP TABLE IF EXISTS GISMO_WEEK_NUMBER;
DROP TABLE IF EXISTS GISMO_TASK_TYPE;
DROP TABLE IF EXISTS GISMO_SUB_VERSION;
DROP TABLE IF EXISTS GISMO_SUB_PROJECT;
DROP TABLE IF EXISTS GISMO_VERSION;
DROP TABLE IF EXISTS GISMO_PROJECT;
DROP TABLE IF EXISTS GISMO_PROJECT_GROUP;
--
-- Structure de la table `GISMO_PROJECT_GROUP`
--

CREATE TABLE `GISMO_PROJECT_GROUP` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `GISMO_PROJECT` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `project_group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Structure de la table `GISMO_SUB_PROJECT`
--

CREATE TABLE `GISMO_SUB_PROJECT` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Structure de la table `GISMO_VERSION`
--

CREATE TABLE `GISMO_VERSION` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Structure de la table `GISMO_SUB_VERSION`
--

CREATE TABLE `GISMO_SUB_VERSION` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sub_project_id` int(11) NOT NULL,
  `version_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Structure de la table `GISMO_TASK_TYPE`
--

CREATE TABLE `GISMO_TASK_TYPE` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('UO','SUPPORT','FORFAIT','') COLLATE utf8_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  `default_task_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Structure de la table `GISMO_WEEK_NUMBER`
--

CREATE TABLE `GISMO_WEEK_NUMBER` (
  `id` int(11) NOT NULL,
  `dateYear` int(11) NOT NULL,
  `dateWeek` int(11) NOT NULL,
  `dateDay` enum('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déclencheurs `GISMO_PROJECT`
--
DELIMITER $$
CREATE TRIGGER `defaultProject` AFTER INSERT ON `GISMO_PROJECT` FOR EACH ROW INSERT INTO GISMO_SUB_PROJECT (name, project_id) VALUES ('DEFAULT', NEW.ID)
$$
DELIMITER ;

--
-- Déclencheurs `GISMO_SUB_PROJECT`
--
DELIMITER $$
CREATE TRIGGER `defaultSubProject` AFTER INSERT ON `GISMO_SUB_PROJECT` FOR EACH ROW INSERT INTO GISMO_SUB_VERSION (name, sub_project_id) VALUES ('DEFAULT', NEW.ID)
$$
DELIMITER ;

--
-- Index pour la table `GISMO_PROJECT_GROUP`
--
ALTER TABLE `GISMO_PROJECT_GROUP`
  ADD PRIMARY KEY (`id`),
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
  
--
-- Index pour la table `GISMO_PROJECT`
--
ALTER TABLE `GISMO_PROJECT`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `project_group_id` (`project_group_id`),
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1,
  ADD CONSTRAINT `GISMO_PROJECT_ibfk_1` FOREIGN KEY (`project_group_id`) REFERENCES `GISMO_PROJECT_GROUP` (`id`) ON DELETE CASCADE;

--
-- Index pour la table `GISMO_SUB_PROJECT`
--
ALTER TABLE `GISMO_SUB_PROJECT`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`),
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1,
  ADD CONSTRAINT `GISMO_SUB_PROJECT_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `GISMO_PROJECT` (`id`) ON DELETE CASCADE;

--
-- Index pour la table `GISMO_VERSION`
--
ALTER TABLE `GISMO_VERSION`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`),
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1,
  ADD CONSTRAINT `GISMO_VERSION_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `GISMO_PROJECT` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
  
--
-- Index pour la table `GISMO_SUB_VERSION`
--
ALTER TABLE `GISMO_SUB_VERSION`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_project_id` (`sub_project_id`),
  ADD KEY `version_id` (`version_id`),
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1,
  ADD CONSTRAINT `GISMO_SUB_VERSION_ibfk_1` FOREIGN KEY (`sub_project_id`) REFERENCES `GISMO_SUB_PROJECT` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Index pour la table `GISMO_TASK_TYPE`
--
ALTER TABLE `GISMO_TASK_TYPE`
  ADD PRIMARY KEY (`id`),
  ADD KEY `TASK_TYPE_ibfk_1` (`project_id`),
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1,
  ADD CONSTRAINT `GISMO_TASK_TYPE_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `GISMO_PROJECT` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
  
  
--
-- Index pour la table `GISMO_WEEK_NUMBER`
--
ALTER TABLE `GISMO_WEEK_NUMBER`
  ADD PRIMARY KEY (`id`),
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
  
CREATE VIEW `GISMO_PROJ`
 AS SELECT 
 grp.id as gismo_proj_grp_id, grp.name as gismo_proj_grp_name,
 proj.id as gismo_proj_id,  proj.name as gismo_proj_name,
 vers.id as gismo_vers_id,  vers.name as gismo_vers_name,
 subP.id as gismo_subP_id,  subP.name as gismo_subP_name
FROM 
GISMO_PROJECT_GROUP as grp, GISMO_PROJECT as proj, GISMO_VERSION as vers, GISMO_SUB_PROJECT as subP
WHERE grp.id =  proj.project_group_id AND proj.id = vers.project_id AND subP.project_id = proj.id;