
-- --------------------------------------------------------

--
-- Structure de la table SUB_VERSION
--

DROP TABLE IF EXISTS SUB_VERSION;
CREATE TABLE SUB_VERSION (
  id int(11) NOT NULL,
  name varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  sub_project_id int(11) NOT NULL,
  version_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
