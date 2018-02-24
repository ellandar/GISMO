
-- --------------------------------------------------------

--
-- Structure de la table `GISMO_SUB_VERSION`
--

CREATE TABLE `GISMO_SUB_VERSION` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sub_project_id` int(11) NOT NULL,
  `version_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
