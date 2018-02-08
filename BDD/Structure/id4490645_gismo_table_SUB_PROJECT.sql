
-- --------------------------------------------------------

--
-- Structure de la table SUB_PROJECT
--

DROP TABLE IF EXISTS SUB_PROJECT;
CREATE TABLE SUB_PROJECT (
  id int(11) NOT NULL,
  name varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  project_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déclencheurs SUB_PROJECT
--
DROP TRIGGER IF EXISTS `defaultSubProject`;
DELIMITER $$
CREATE TRIGGER `defaultSubProject` AFTER INSERT ON `SUB_PROJECT` FOR EACH ROW INSERT INTO SUB_VERSION (name, sub_project_id) VALUES ('DEFAULT', NEW.ID)
$$
DELIMITER ;
