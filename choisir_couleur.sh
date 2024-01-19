#!/bin/bash

# Vérifie si le nombre d'arguments est correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <nomDuProjet>"
    exit 1
fi

# Récupère le nom du projet à partir des arguments
nomDuProjet="$1"

couleurDuProjet=""

echo "Vérification pour ${nomDuProjet}-blue..."
echo docker ps -q -f name="${nomDuProjet}-blue" | grep -q .
if docker ps -q -f name="${nomDuProjet}-blue" | grep -q . ; then
    couleurDuProjet="green"
    echo "Choix de la couleur : ${couleurDuProjet}"
else
    echo "Vérification pour ${nomDuProjet}-green..."
    if docker ps -q -f name="${nomDuProjet}-green" | grep -q . ; then
        couleurDuProjet="blue"
        echo "Choix de la couleur : ${couleurDuProjet}"
    else
        couleurDuProjet="green"
        echo "Aucun conteneur trouvé, choix de la couleur par défaut : ${couleurDuProjet}"
    fi
fi

echo "la couleur du projet à installer est $couleurDuProjet"

echo "env=$couleurDuProjet" > .env