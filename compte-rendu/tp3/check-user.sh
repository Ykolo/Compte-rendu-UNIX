#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Erreur vous devez rentrer un seul paramètre"
    echo "Usage: $@"
    exit 1
fi

PARAM=$1
PASSWD_FILE="/etc/passwd"

RESULT=$(awk -F: -v p="$PARAM" '$1 == p || $3 == p { print $3 }' "$PASSWD_FILE")

if [ -n "$RESULT" ]; then
    echo "$RESULT"
fi
