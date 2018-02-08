
-- --------------------------------------------------------

--
-- Structure de la table USER_PROFILE
--

DROP TABLE IF EXISTS USER_PROFILE;
CREATE ALGORITHM=UNDEFINED DEFINER=id4490645_lbarre@`%` SQL SECURITY DEFINER VIEW USER_PROFILE  AS  select distinct id4490645_gismo.`USER`.`name` AS `user`,id4490645_gismo.PROFIL.`type` AS `profile`,'' AS `name` from (((`USER` join PROFIL) join PROJECT_GROUP) join PROJECT) where ((id4490645_gismo.`USER`.`id` = id4490645_gismo.PROFIL.user_id) and (id4490645_gismo.PROFIL.project_group_id = NULL) and (id4490645_gismo.PROFIL.project_id = NULL)) union select distinct id4490645_gismo.`USER`.`name` AS `user`,id4490645_gismo.PROFIL.`type` AS `profile`,id4490645_gismo.PROJECT_GROUP.`name` AS `name` from (((`USER` join PROFIL) join PROJECT_GROUP) join PROJECT) where ((id4490645_gismo.`USER`.`id` = id4490645_gismo.PROFIL.user_id) and (id4490645_gismo.PROFIL.project_group_id = id4490645_gismo.PROJECT_GROUP.`id`)) union select distinct id4490645_gismo.`USER`.`name` AS `user`,id4490645_gismo.PROFIL.`type` AS `profile`,id4490645_gismo.PROJECT.`name` AS `name` from ((`USER` join PROFIL) join PROJECT) where ((id4490645_gismo.`USER`.`id` = id4490645_gismo.PROFIL.user_id) and (id4490645_gismo.PROFIL.project_id = id4490645_gismo.PROJECT.`id`)) order by '' ;
