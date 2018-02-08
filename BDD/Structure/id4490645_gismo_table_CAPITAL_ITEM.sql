
-- --------------------------------------------------------

--
-- Structure de la table CAPITAL_ITEM
--

DROP TABLE IF EXISTS CAPITAL_ITEM;
CREATE TABLE CAPITAL_ITEM (
  id int(11) NOT NULL,
  name varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  subProject_name varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
