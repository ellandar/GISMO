
-- --------------------------------------------------------

--
-- Structure de la table CAPITAL_SUBTYPE
--

DROP TABLE IF EXISTS CAPITAL_SUBTYPE;
CREATE TABLE CAPITAL_SUBTYPE (
  id int(11) NOT NULL,
  capitalSubType varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  capitalItem varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  project_id int(11) NOT NULL,
  taskTypeId int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
