#!/bin/bash 

#counting the elements contained in each directory
CURDIR=$1
COUNT1=$(ls $CURDIR | wc -w )

#-isolate the dates field - put them in order - select the fisrt and the last date for each directory - add "future" as date for empty directories
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

#calcul the weight of each directory
SIZES=$(ls -l $CURDIR  |  sed -r 's/ +/ /g' | grep -Ev '^d' | cut -f5 -d" ")
TOTALSIZE=0
for i in $SIZES
do
	TOTALSIZE=$(( $TOTALSIZE + ${i} ))
done

#goes through all the pdf files into directories and extract the font list for each pdf
PDFS=$(ls $CURDIR | grep *.pdf)
PDFFONTS=''
for i in $PDFS
do
    PDFFONTS=${PDFFONTS}‽$CURDIR/$i‼$(fontforge -lang=ff -c "Print(StrJoin(FontsInFile('$CURDIR/$i'), '⁇'))")
	
done

echo $CURDIR $COUNT1 $COUNT2 $START $END $TOTALSIZE $PDFFONTS
