# find . -type f -exec ../osp.residency.masereel/sizes.sh {} \;  


#!/bin/bash 

CURDIR=$1

ls -l $CURDIR| cut -f5 -d" " | sort -n))


echo $CURDIR $START $END

# lister chaque fichier contenu dans le dossier (pas les sous-dossiers)
# additionner leur poids
# assigner le résultat de cette addition au dossier


#lister les infos de chaque dossier contenus dans la liste des dossiers

#dans le 6e field celui de la date, 
#trier par ordre chronologique,
#extraire le premier et le dernier de la liste chronologique
