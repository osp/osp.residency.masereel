#!/bin/bash 
SOURCE=w_nas.ls
TARGET=ext.ls
TEMPFILE=tmp.ls
TEMPFILE2=tmp2.ls
#list of required
REQPAT='\.'
grep ${REQPAT} ${SOURCE} > ${TEMPFILE}

echo "REQ => " $(cat ${TEMPFILE} | wc -l)

sed -r 's/.*.\.(.*)/\1/'  ${TEMPFILE} > ${TEMPFILE2}
cat ${TEMPFILE2} > ${TEMPFILE}
#list of extension we want to remove
REMOVELIST=": \.gvfs week total fcp_ 2011 2006 2007 2010 2003"
for i in ${REMOVELIST}
do 
	
	grep -v -E ${i} ${TEMPFILE} > ${TEMPFILE2}
	echo "${i} => " $(cat ${TEMPFILE2} | wc -l)
	cat ${TEMPFILE2} > ${TEMPFILE}
done 

cat ${TEMPFILE} |sort|uniq -i > ${TARGET}