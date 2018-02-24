-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le :  sam. 24 fév. 2018 à 17:00
-- Version du serveur :  10.1.31-MariaDB
-- Version de PHP :  7.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `id4490645_gismo`
--
DROP VIEW GISMO_PROJ;
CREATE VIEW `GISMO_PROJ`
 AS SELECT 
 grp.id as gismo_proj_grp_id, grp.name as gismo_proj_grp_name,
 proj.id as gismo_proj_id,  proj.name as gismo_proj_name,
 vers.id as gismo_vers_id,  vers.name as gismo_vers_name,
 subP.id as gismo_subP_id,  subP.name as gismo_subP_name
FROM 
GISMO_PROJECT_GROUP as grp, GISMO_PROJECT as proj, GISMO_VERSION as vers, GISMO_SUB_PROJECT as subP
WHERE grp.id =  proj.project_group_id AND proj.id = vers.project_id AND subP.project_id = proj.id;


DROP VIEW `GISMO_PROF_VIEW`;
CREATE VIEW `GISMO_PROF_VIEW`
 AS SELECT gUser.id as gismo_user_id, gUser.name as gismo_user_name, prof.type as gismo_profil, '' as obj_id, '' as obj_name
FROM GISMO_USER as gUser, GISMO_PROFIL as prof
WHERE gUser.id = prof.user_id AND prof.project_group_id is null AND prof.project_id is null 
UNION
SELECT gUser.id as gismo_user_id, gUser.name as gismo_user_name, prof.type as gismo_profil, grp.id, grp.name
FROM GISMO_USER as gUser, GISMO_PROFIL as prof, GISMO_PROJECT_GROUP as grp
WHERE gUser.id = prof.user_id AND prof.project_group_id = grp.id AND prof.project_id is null 
UNION
SELECT gUser.id as gismo_user_id, gUser.name as gismo_user_name, prof.type as gismo_profil, proj.id, proj.name
FROM GISMO_USER as gUser, GISMO_PROFIL as prof, GISMO_PROJECT as proj
WHERE gUser.id = prof.user_id AND prof.project_group_id is null AND prof.project_id = proj.id;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
