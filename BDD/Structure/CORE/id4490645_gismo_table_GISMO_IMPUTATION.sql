
-- --------------------------------------------------------

--
-- Structure de la table `GISMO_IMPUTATION`
--

CREATE TABLE `GISMO_IMPUTATION` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `imputDate` date NOT NULL,
  `imputTime` int(11) NOT NULL,
  `detail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `weekNumberId` int(11) NOT NULL,
  `warning` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `error` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
