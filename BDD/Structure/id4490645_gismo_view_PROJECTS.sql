
-- --------------------------------------------------------

--
-- Structure de la vue PROJECTS
--
DROP TABLE IF EXISTS `PROJECTS`;

CREATE ALGORITHM=UNDEFINED DEFINER=id4490645_lbarre@`%` SQL SECURITY DEFINER VIEW PROJECTS  AS  select grp.`id` AS GRP_ID,grp.`name` AS GRP_NAME,proj.`id` AS PROJ_ID,proj.`name` AS PROJ_NAME,vers.`id` AS VERS_ID,vers.`name` AS VERS_NAME,subP.`id` AS SUBPRJ_ID,subP.`name` AS SUBPRJ_NAME,subV.`id` AS SUBVERS_ID,subV.`name` AS SUBVERS_NAME from ((((PROJECT_GROUP grp join PROJECT proj) join VERSION vers) join SUB_PROJECT subP) join SUB_VERSION subV) where ((grp.`id` = proj.project_group_id) and (proj.`id` = vers.project_id) and (subP.project_id = proj.`id`) and (subV.sub_project_id = subP.`id`)) ;
