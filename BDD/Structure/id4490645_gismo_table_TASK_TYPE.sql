
-- --------------------------------------------------------

--
-- Structure de la table TASK_TYPE
--

DROP TABLE IF EXISTS TASK_TYPE;
CREATE TABLE TASK_TYPE (
  id int(11) NOT NULL,
  name varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  type enum('UO','SUPPORT','FORFAIT','') COLLATE utf8_unicode_ci NOT NULL,
  project_id int(11) NOT NULL,
  default_task_id int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
