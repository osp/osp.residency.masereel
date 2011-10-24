#!/bin/bash 

CURDIR=$1 ; 
MYARRAY=$(ls -l $CURDIR  |  sed -r 's/ +/ /g' | grep -Ev '^d' | cut -f5 -d" ")

TOTALSIZE=0
for i in $MYARRAY
do
#	echo ${i}
	TOTALSIZE=$(( $TOTALSIZE + ${i} ))
done

echo $CURDIR $TOTALSIZE

# lister chaque fichier contenu dans le dossier (pas les sous-dossiers)
# additionner leur poids
# assigner le résultat de cette addition au dossier

# find . -type f -exec ../osp.residency.masereel/sizes.sh {} \;  