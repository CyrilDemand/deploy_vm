#!/bin/bash

# Vérifie si le nombre d'arguments est correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <nomDuProjet>"
    exit 1
fi

# Récupère le nom du projet à partir des arguments
nomDuProjet="$1"

couleurDuProjet=""

# Vérifie si le conteneur "nomDuProjet-blue" est en cours d'exécution
if docker ps -q -f name="${nomDuProjet}-blue" | grep -q .; then
    couleurDuProjet="green"
else
    # Vérifie si le conteneur "nomDuProjet-green" est en cours d'exécution
    if docker ps -q -f name="${nomDuProjet}-green" | grep -q .; then
        couleurDuProjet="blue"
    else
        # Si aucun des conteneurs n'est en cours d'exécution, utilise "green" par défaut
        couleurDuProjet="green"
    fi
fi

echo "la couleur du projet à installer est $couleurDuProjet"

echo "env=$couleurDuProjet" > .env