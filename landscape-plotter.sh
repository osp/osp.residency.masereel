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

MYSEP=''
EXTS=''
for i in $(find $CURDIR -maxdepth 1 -type f)
do
	EXTS=${EXTS}${MYSEP}$(basename "$i" | sed -r 's/.+\.(.̉*)/\1/')
	MYSEP=':'
done

SCRIPT=<<EOF
fn=$argv[1]
names=FontsInFile(fn)
Print(StrJoin(names, "⁇"))
EOF

PDFS=$(ls $CURDIR | grep *.pdf)
PDFFONTS=''
for i in $PDFS
do
    PDFFONTS=${PDFFONTS}‽$CURDIR/$i‼$(fontforge -lang=ff -c "Print(StrJoin(FontsInFile('$CURDIR/$i'), '⁇'))")
	
done

echo $CURDIR ';' $COUNT1 ';' $TOTALSIZE ';' $START ';' $END ';' $EXTS ';' $PDFFONTS
