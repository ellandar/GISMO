
-- --------------------------------------------------------

--
-- Structure de la table `VERSION`
--

DROP TABLE IF EXISTS VERSION;
CREATE TABLE VERSION (
  id int(11) NOT NULL,
  name varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  project_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
