#!/bin/bash

# Vérifie si Docker est déjà installé
if ! [ -x "$(command -v docker)" ]; then
  echo "Docker n'est pas installé. Installation en cours..."

  # Installation de Docker en utilisant le script officiel d'installation
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh

  # Ajout de l'utilisateur actuel au groupe docker pour pouvoir exécuter des commandes Docker sans sudo
  sudo usermod -aG docker $USER

  echo "Docker a été installé avec succès."
else
  echo "Docker est déjà installé."
fi
