
-- --------------------------------------------------------

--
-- Structure de la table `GISMO_TASK_LINK`
--

CREATE TABLE `GISMO_TASK_LINK` (
  `child_task_id` int(11) NOT NULL,
  `parent_task_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
