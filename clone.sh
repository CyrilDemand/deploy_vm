#!/bin/bash

# Vérifie si le nombre d'arguments est correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 lien github du projet"
    exit 1
fi

# Choix de la couleur du projet et création du fichier .env
./choisir_couleur.sh "$1"

lien_git="$1"

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

echo "on va lancer le script de build de clone en $couleurDuProjet avec comme lien $lien_git"

# si la couleur vaut green, lancer le build.sh du dossier projet_g/$projet/deploy/linux
# sinon, lancer le build.sh du dossier projet_b/$projet/deploy/linux
if [ "$couleurDuProjet" = "green" ]; then
    cd projet_g/ && git clone "$lien_git" && cd ..
else
    echo "on va lancer le script de build de $projet en blue"
    cd projet_b/ && git clone "$lien_git" && cd ..
fi