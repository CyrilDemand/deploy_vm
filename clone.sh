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
    rm -rf projet_g/"$derniere_partie"
    cd projet_g/ && git clone "$lien_git" && cd "$derniere_partie" && git checkout "$id_commit" && cd ../..
else
    echo "on va lancer le script de build de $projet en blue"
    rm -rf projet_g/"$derniere_partie"
    cd projet_b/ && git clone "$lien_git" && cd "$derniere_partie" && git checkout "$id_commit" && cd ../..
fi