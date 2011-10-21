#!/bin/bash 

CURDIR=$1
COUNT1=$(ls $CURDIR | wc -w )

MYARRAY1=($(ls -l $CURDIR| cut -f6 -d" " | sort -n))
COUNT2=0
for i in $MYARRAY1
do 
	COUNT2=$(( $COUNT2 + 1 ))
done
START=future
END=future
if [[ $COUNT2 -gt 0 ]]
then 
	START=${MYARRAY1[0]}
	END=${MYARRAY1[-1]}
fi

SIZES=$(ls -l $CURDIR  |  sed -r 's/ +/ /g' | grep -Ev '^d' | cut -f5 -d" ")
TOTALSIZE=0
for i in $SIZES
do
	TOTALSIZE=$(( $TOTALSIZE + ${i} ))
done

echo $CURDIR $COUNT1 $COUNT2 $START $END $TOTALSIZE
