#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Erreur : Vous devez spécifier un répertoire en paramètre."
    echo "Usage : $0 <chemin_du_repertoire>"
    exit 1
fi

REP=$1

if [ ! -d "$REP" ]; then
    echo "Erreur : '$REP' n'est pas un répertoire valide ou n'existe pas."
    exit 1
fi

echo "####### fichier dans $REP/"
for item in "$REP"/*; do
    if [ -f "$item" ]; then
        echo "$item"
    fi
done

echo "####### repertoires dans $REP/"
for item in "$REP"/*; do
    if [ -d "$item" ]; then
        echo "$item"
    fi
done
