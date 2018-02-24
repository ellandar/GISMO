
-- --------------------------------------------------------

--
-- Structure de la table `GISMO_USER`
--

CREATE TABLE `GISMO_USER` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `trigramme` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `CAPITAL_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `JIRA_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
