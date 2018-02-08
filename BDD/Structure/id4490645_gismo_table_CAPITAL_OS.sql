
-- --------------------------------------------------------

--
-- Structure de la table CAPITAL_OS
--

DROP TABLE IF EXISTS CAPITAL_OS;
CREATE TABLE CAPITAL_OS (
  id int(11) NOT NULL,
  ident varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  name varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  project_id int(11) NOT NULL,
  version_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
