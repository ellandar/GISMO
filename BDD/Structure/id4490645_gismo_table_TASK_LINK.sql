
-- --------------------------------------------------------

--
-- Structure de la table TASK_LINK
--

DROP TABLE IF EXISTS TASK_LINK;
CREATE TABLE TASK_LINK (
  child_task_id int(11) NOT NULL,
  parent_task_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
