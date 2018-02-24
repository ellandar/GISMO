
--
-- Index pour les tables déchargées
--

--
-- Index pour la table `GISMO_IMPUTATION`
--
ALTER TABLE `GISMO_IMPUTATION`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_id` (`task_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `GISMO_PROFIL`
--
ALTER TABLE `GISMO_PROFIL`
  ADD PRIMARY KEY (`id`),
  ADD KEY `PROFIL_ibfk_1` (`project_group_id`),
  ADD KEY `PROFIL_ibfk_2` (`user_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Index pour la table `GISMO_PROJECT`
--
ALTER TABLE `GISMO_PROJECT`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `project_group_id` (`project_group_id`);

--
-- Index pour la table `GISMO_PROJECT_GROUP`
--
ALTER TABLE `GISMO_PROJECT_GROUP`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `GISMO_SUB_PROJECT`
--
ALTER TABLE `GISMO_SUB_PROJECT`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Index pour la table `GISMO_SUB_VERSION`
--
ALTER TABLE `GISMO_SUB_VERSION`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_project_id` (`sub_project_id`),
  ADD KEY `version_id` (`version_id`);

--
-- Index pour la table `GISMO_TASK`
--
ALTER TABLE `GISMO_TASK`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_type_id` (`task_type_id`),
  ADD KEY `projectId` (`project_Id`),
  ADD KEY `subVersion_Id` (`sub_version_Id`),
  ADD KEY `version_id` (`version_id`),
  ADD KEY `TASK_ibfk_2` (`sub_project_id`);

--
-- Index pour la table `GISMO_TASK_LINK`
--
ALTER TABLE `GISMO_TASK_LINK`
  ADD PRIMARY KEY (`child_task_id`,`parent_task_id`),
  ADD KEY `child_task_id` (`child_task_id`),
  ADD KEY `parent_task_id` (`parent_task_id`);

--
-- Index pour la table `GISMO_TASK_TYPE`
--
ALTER TABLE `GISMO_TASK_TYPE`
  ADD PRIMARY KEY (`id`),
  ADD KEY `TASK_TYPE_ibfk_1` (`project_id`);

--
-- Index pour la table `GISMO_USER`
--
ALTER TABLE `GISMO_USER`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trigramme` (`trigramme`);

--
-- Index pour la table `GISMO_VERSION`
--
ALTER TABLE `GISMO_VERSION`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Index pour la table `GISMO_WEEK_NUMBER`
--
ALTER TABLE `GISMO_WEEK_NUMBER`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `GISMO_IMPUTATION`
--
ALTER TABLE `GISMO_IMPUTATION`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `GISMO_PROFIL`
--
ALTER TABLE `GISMO_PROFIL`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT pour la table `GISMO_SUB_VERSION`
--
ALTER TABLE `GISMO_SUB_VERSION`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT pour la table `GISMO_TASK`
--
ALTER TABLE `GISMO_TASK`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `GISMO_TASK_TYPE`
--
ALTER TABLE `GISMO_TASK_TYPE`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `GISMO_VERSION`
--
ALTER TABLE `GISMO_VERSION`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT pour la table `GISMO_WEEK_NUMBER`
--
ALTER TABLE `GISMO_WEEK_NUMBER`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1829;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `GISMO_IMPUTATION`
--
ALTER TABLE `GISMO_IMPUTATION`
  ADD CONSTRAINT `GISMO_IMPUTATION_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `GISMO_TASK` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_IMPUTATION_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `GISMO_USER` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `GISMO_PROFIL`
--
ALTER TABLE `GISMO_PROFIL`
  ADD CONSTRAINT `GISMO_PROFIL_ibfk_1` FOREIGN KEY (`project_group_id`) REFERENCES `GISMO_PROJECT_GROUP` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_PROFIL_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `GISMO_USER` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_PROFIL_ibfk_3` FOREIGN KEY (`project_id`) REFERENCES `GISMO_PROJECT` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `GISMO_PROJECT`
--
ALTER TABLE `GISMO_PROJECT`
  ADD CONSTRAINT `GISMO_PROJECT_ibfk_1` FOREIGN KEY (`project_group_id`) REFERENCES `GISMO_PROJECT_GROUP` (`id`);

--
-- Contraintes pour la table `GISMO_SUB_PROJECT`
--
ALTER TABLE `GISMO_SUB_PROJECT`
  ADD CONSTRAINT `GISMO_SUB_PROJECT_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `GISMO_PROJECT` (`id`);

--
-- Contraintes pour la table `GISMO_SUB_VERSION`
--
ALTER TABLE `GISMO_SUB_VERSION`
  ADD CONSTRAINT `GISMO_SUB_VERSION_ibfk_1` FOREIGN KEY (`sub_project_id`) REFERENCES `GISMO_SUB_PROJECT` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `GISMO_TASK`
--
ALTER TABLE `GISMO_TASK`
  ADD CONSTRAINT `GISMO_TASK_ibfk_2` FOREIGN KEY (`sub_project_id`) REFERENCES `GISMO_SUB_PROJECT` (`id`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_TASK_ibfk_3` FOREIGN KEY (`version_id`) REFERENCES `GISMO_VERSION` (`id`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_TASK_ibfk_4` FOREIGN KEY (`task_type_id`) REFERENCES `GISMO_TASK_TYPE` (`id`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_TASK_ibfk_5` FOREIGN KEY (`sub_version_Id`) REFERENCES `GISMO_SUB_VERSION` (`id`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_TASK_ibfk_6` FOREIGN KEY (`project_Id`) REFERENCES `GISMO_PROJECT` (`id`) ON UPDATE NO ACTION;

--
-- Contraintes pour la table `GISMO_TASK_LINK`
--
ALTER TABLE `GISMO_TASK_LINK`
  ADD CONSTRAINT `GISMO_TASK_LINK_ibfk_1` FOREIGN KEY (`parent_task_id`) REFERENCES `GISMO_TASK` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `GISMO_TASK_LINK_ibfk_2` FOREIGN KEY (`child_task_id`) REFERENCES `GISMO_TASK` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `GISMO_TASK_TYPE`
--
ALTER TABLE `GISMO_TASK_TYPE`
  ADD CONSTRAINT `GISMO_TASK_TYPE_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `GISMO_PROJECT` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `GISMO_VERSION`
--
ALTER TABLE `GISMO_VERSION`
  ADD CONSTRAINT `GISMO_VERSION_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `GISMO_PROJECT` (`id`);
