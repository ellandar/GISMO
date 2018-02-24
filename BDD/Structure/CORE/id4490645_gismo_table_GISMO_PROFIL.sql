
-- --------------------------------------------------------

--
-- Structure de la table `GISMO_PROFIL`
--

CREATE TABLE `GISMO_PROFIL` (
  `id` int(11) NOT NULL,
  `type` enum('USER','ADMIN','CDP','') COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `project_group_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
