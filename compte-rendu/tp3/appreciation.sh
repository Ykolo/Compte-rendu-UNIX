#!/bin/bash

echo "--- Système d'appréciation (tapez 'q' pour quitter) ---"

while true; do
    echo -n "Entrez une note (0-20) : "
    read saisie

    if [ "$saisie" = "q" ]; then
        echo "Au revoir !"
        break
    fi

    if [[ ! "$saisie" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        echo "Erreur : Veuillez entrer un nombre valide ou 'q'."
        continue
    fi

   note=$saisie

    if (( $(echo "$note >= 16 && $note <= 20" | bc -l) )); then
        echo "Résultat : Très bien"
    elif (( $(echo "$note >= 14 && $note < 16" | bc -l) )); then
        echo "Résultat : Bien"
    elif (( $(echo "$note >= 12 && $note < 14" | bc -l) )); then
        echo "Résultat : Assez bien"
    elif (( $(echo "$note >= 10 && $note < 12" | bc -l) )); then
        echo "Résultat : Moyen"
    elif (( $(echo "$note < 10" | bc -l) )); then
        echo "Résultat : Insuffisant"
    else
        echo "Erreur : La note doit être entre 0 et 20."
    fi
done
