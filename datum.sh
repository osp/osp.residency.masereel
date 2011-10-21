#!/bin/bash 


CURDIR=$1

MYARRAY=($(ls -l $CURDIR| cut -f6 -d" " | sort -n))
START=${MYARRAY[0]}
END=${MYARRAY[-1]}

echo $CURDIR $START $END

#lister les infos de chaque dossier contenus dans la liste des dossiers

#dans le 6e field celui de la date, 
#trier par ordre chronologique,
#extraire le premier et le dernier de la liste chronologique

