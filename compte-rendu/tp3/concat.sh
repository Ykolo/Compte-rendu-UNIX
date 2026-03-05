#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Erreur : Vous devez rentrer exactement 2 paramètres."
    exit 1
fi

CONCAT="$1$2"
echo "Résultat : $CONCAT"
