#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Erreur: Vous devez rentrez au moins un paramètre"
    echo "Usage: $0 <nom_du_fichier>"
    exit 1
fi

FICHIER=$1

if [ ! -e "$FICHIER" ]; then
    echo "Le fichier $FICHIER n'existe pas."
    exit 1
fi

if [ -d "$FICHIER" ]; then
    TYPE="un répertoire"
elif [ -f "$FICHIER" ]; then
    TYPE="un fichier ordinaire"
else
    TYPE="un type spécial"
fi

DROITS=""
[ -r "$FICHIER" ] && DROITS="$DROITS lecture"
[ -w "$FICHIER" ] && DROITS="$DROITS écriture"
[ -x "$FICHIER" ] && DROITS="$DROITS exécution"

echo "Le fichier $FICHIER est $TYPE."
echo "\"$FICHIER\" est accessible par $USER en $DROITS."
