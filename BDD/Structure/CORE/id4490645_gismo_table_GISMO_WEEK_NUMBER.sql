
-- --------------------------------------------------------

--
-- Structure de la table `GISMO_WEEK_NUMBER`
--

CREATE TABLE `GISMO_WEEK_NUMBER` (
  `id` int(11) NOT NULL,
  `dateYear` int(11) NOT NULL,
  `dateWeek` int(11) NOT NULL,
  `dateDay` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday','','','') COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
