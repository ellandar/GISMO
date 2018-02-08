
-- --------------------------------------------------------

--
-- Structure de la table PROJECT
--

DROP TABLE IF EXISTS PROJECT;
CREATE TABLE PROJECT (
  id int(11) NOT NULL,
  name varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  project_group_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déclencheurs PROJECT
--
DROP TRIGGER IF EXISTS `defaultProject`;
DELIMITER $$
CREATE TRIGGER `defaultProject` AFTER INSERT ON `PROJECT` FOR EACH ROW INSERT INTO SUB_PROJECT (id,name, project_id) SELECT MAX(id) +1, "DEFAULT", NEW.id FROM SUB_PROJECT;
$$
DELIMITER ;
