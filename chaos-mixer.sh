#!/bin/bash 

CURDIR=$1
COUNT=$(ls $CURDIR | wc -w )

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
MYARRAY=$(ls -l $CURDIR  |  sed -r 's/ +/ /g' | grep -Ev '^d' | cut -f5 -d" ")
TOTALSIZE=0
for i in $MYARRAY
do
	TOTALSIZE=$(( $TOTALSIZE + ${i} ))
done

echo $CURDIR $COUNT $START $END $TOTALSIZE
