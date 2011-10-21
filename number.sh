#!/bin/bash 


CURDIR=$1

COUNT=$(ls $CURDIR | wc -w )

echo $CURDIR $COUNT

#lister le nombre de fichiers dans chaque dossier et sous dossiers
#additioner le nombre de fichiers contenus dans chaque dossier
#donner le total de fichiers contenus dans chaque dossier