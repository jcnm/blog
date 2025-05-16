#!/bin/bash

# Configuration
LOCAL_DIR="/Users/jcnm/www/jcnm"

# Supprimer l'ancien build
echo "Nettoyage du répertoire public existant..."
rm -rf $LOCAL_DIR/public

# Générer le nouveau site
echo "Génération du site avec Hugo..."
OLDPWD=$(pwd)
# Vérifier si le répertoire public existe
if [ ! -d "$LOCAL_DIR" ]; then
    echo "Le répertoire contenant public ($LOCAL_DIR) n'existe pas. Veuillez vérifier le chemin."
    exit 1
fi

cd "$LOCAL_DIR"
if [ $? -ne 0 ]; then
    echo "Erreur lors du changement de répertoire."
    exit 1
fi
# Vérifier si Hugo est installé
if ! command -v hugo &> /dev/null; then
    echo "Hugo n'est pas installé. Veuillez l'installer pour continuer."
    exit 1
fi
echo "Génération du site... dans le répertoire $LOCAL_DIR"

hugo

# Vérifier si la génération a réussi
if [ $? -ne 0 ]; then
    echo "Erreur lors de la génération du site."
    exit 1
fi


cd $OLDPWD

echo "Génération terminé avec succès!"