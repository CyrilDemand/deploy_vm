#!/bin/bash

# Vérifie si le dossier projet_g existe
if [ ! -d "projet_g" ]; then
    # Crée le dossier projet_g s'il n'existe pas
    mkdir "projet_g"
    echo "Dossier projet_g créé."
else
    echo "Le dossier projet_g existe déjà."
fi

# Vérifie si le dossier projet_b existe
if [ ! -d "projet_b" ]; then
    # Crée le dossier projet_b s'il n'existe pas
    mkdir "projet_b"
    echo "Dossier projet_b créé."
else
    echo "Le dossier projet_b existe déjà."
fi
