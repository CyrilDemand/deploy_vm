#!/bin/bash

# Vérifie si le nombre d'arguments est correct
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <nomDuProjet> <nomDuScript>"
    exit 1
fi

projet="$1"
script="$2"
# Vérifie si le fichier .env existe
couleurDuProjet=""
if [ -f .env ]; then
    # Utilise grep pour rechercher la ligne contenant "env" dans le fichier .env
    ligne_env=$(grep "env=" .env)

    # Extrait la valeur de la variable en supprimant le préfixe "env="
    couleurDuProjet=${ligne_env#*=}

    echo "La valeur de env est : $couleurDuProjet"
else
    echo "Le fichier .env n'existe pas."
fi

echo "on va lancer le script de build de $projet en $couleurDuProjet"

# si la couleur vaut green, lancer le build.sh du dossier projet_g/$projet/deploy/linux
# sinon, lancer le build.sh du dossier projet_b/$projet/deploy/linux
if [ "$couleurDuProjet" = "green" ]; then
    echo "on va lancer le script de build de $projet en green"
    chmod u+x ./projet_g/"$projet"/deploy/linux/"$script".sh
    cd projet_g/"$projet"/deploy/linux && ./"$script".sh && cd ../../../../
else
    chmod u+x ./projet_b/"$projet"/deploy/linux/"$script".sh
    echo "on va lancer le script de build de $projet en blue"
    cd projet_b/"$projet"/deploy/linux && ./"$script".sh && cd ../../../../
fi