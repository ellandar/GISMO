
-- --------------------------------------------------------

--
-- Structure de la table PROJECT_GROUP
--

DROP TABLE IF EXISTS PROJECT_GROUP;
CREATE TABLE PROJECT_GROUP (
  id int(11) NOT NULL,
  name varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
