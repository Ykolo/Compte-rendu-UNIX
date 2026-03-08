#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <repertoire>"
    exit 1
fi

DIR=$1

if [ ! -d "$DIR" ]; then
    echo "Erreur : Le dossier '$DIR' n'existe pas."
    exit 1
fi

for fichier in "$DIR"/*; do
    if [ -f "$fichier" ]; then
       if file "$fichier" | grep -q "text"; then
           echo -n "Voulez-vous visualiser le fichier $(basename "$fichier") ? (y/n) : "
            read reponse            
            if [ "$reponse" = "y" ] || [ "$reponse" = "o" ]; then
                more "$fichier"
            fi
            echo "------------------------------------------"
        fi
    fi
done

echo "Fin de l'examen du répertoire."
