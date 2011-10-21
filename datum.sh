#!/bin/bash 


CURDIR=$1

MYARRAY=($(ls -l $CURDIR| cut -f6 -d" " | sort -n))
COUNT=0
for i in $MYARRAY
do 
	COUNT=$COUNT+1
done


START=future
END=future

if [[ $COUNT -gt 0 ]]
then 
	START=${MYARRAY[0]}
	END=${MYARRAY[-1]}
fi

echo $CURDIR $START $END

#lister les infos de chaque dossier contenus dans la liste des dossiers
#dans le 6e field celui de la date, 
#trier par ordre chronologique,
#extraire le premier et le dernier de la liste chronologique