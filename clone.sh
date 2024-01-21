#!/bin/bash

# Vérifie si le nombre d'arguments est correct
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 lien github du projet" "id du commit"
    exit 1
fi

derniere_partie=$(basename "$lien_complet")

echo "$derniere_partie"
# Choix de la couleur du projet et création du fichier .env
./choisir_couleur.sh "$derniere_partie"

lien_git="$1"
id_commit="$2"

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
    echo "Cloning and building for green project..."
    rm -rf projet_g/"$derniere_partie"/*
    cd projet_g/ || exit
    git clone "$lien_git"
    if [ $? -eq 0 ]; then
        cd "$derniere_partie" || exit
        git checkout "$id_commit"
        if [ $? -eq 0 ]; then
            echo "Successfully checked out the commit."
            # Here you can add the command to launch build.sh or any other script
        else
            echo "Failed to checkout the commit."
            exit 1
        fi
    else
        echo "Failed to clone the repository."
        exit 1
    fi
    cd ../..
else
    echo "Cloning and building for blue project..."
    rm -rf projet_b/"$derniere_partie"/*
    cd projet_b/ || exit
    git clone "$lien_git"
    if [ $? -eq 0 ]; then
        cd "$derniere_partie" || exit
        git checkout "$id_commit"
        if [ $? -eq 0 ]; then
            echo "Successfully checked out the commit."
            # Here you can add the command to launch build.sh or any other script
        else
            echo "Failed to checkout the commit."
            exit 1
        fi
    else
        echo "Failed to clone the repository."
        exit 1
    fi
    cd ../..
fi