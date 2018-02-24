
--
-- Index pour les tables déchargées
--

--
-- Index pour la table `JIRA_STATES`
--
ALTER TABLE `JIRA_STATES`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `JIRA_TASK`
--
ALTER TABLE `JIRA_TASK`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `JIRA_TASK_TYPE`
--
ALTER TABLE `JIRA_TASK_TYPE`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_type_id` (`task_type_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `JIRA_STATES`
--
ALTER TABLE `JIRA_STATES`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `JIRA_TASK`
--
ALTER TABLE `JIRA_TASK`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `JIRA_TASK_TYPE`
--
ALTER TABLE `JIRA_TASK_TYPE`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `JIRA_TASK_TYPE`
--
ALTER TABLE `JIRA_TASK_TYPE`
  ADD CONSTRAINT `JIRA_TASK_TYPE_ibfk_1` FOREIGN KEY (`task_type_id`) REFERENCES `GISMO_TASK_TYPE` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
