#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Erreur : Ce script doit être exécuté en tant que root (sudo)."
    exit 1
fi

echo "--- Création d'un nouvel utilisateur ---"
read -p "Login : " LOGIN
read -p "Nom : " NOM
read -p "Prénom : " PRENOM
read -p "UID (laisser vide pour auto) : " USER_UID
read -p "GID (laisser vide pour défaut) : " USER_GID
read -p "Commentaires : " COMMENT

if id "$LOGIN" &>/dev/null; then
    echo "Erreur : L'utilisateur '$LOGIN' existe déjà."
    exit 1
fi

HOME_DIR="/home/$LOGIN"
if [ -d "$HOME_DIR" ]; then
    echo "Erreur : Le répertoire $HOME_DIR existe déjà sur le disque."
    exit 1
fi

FULL_COMMENT="$PRENOM $NOM - $COMMENT"
ARGS="-m -d $HOME_DIR -c \"$FULL_COMMENT\""

if [ -n "$USER_UID" ]; then ARGS="$ARGS -u $USER_UID"; fi
if [ -n "$USER_GID" ]; then ARGS="$ARGS -g $USER_GID"; fi

useradd $ARGS "$LOGIN"

if [ $? -eq 0 ]; then
    echo "Succès : L'utilisateur '$LOGIN' a été créé avec son home dans $HOME_DIR."
else
    echo "Erreur lors de la création de l'utilisateur."
    exit 1
fi
