#!/bin/bash

IN="/Users/menzowi/Documents/Projects/VLB/huc-cmdi-app/html/ccf/data/records/inprogress/"
for REC in `find ${IN} -type f -name "record.cmdi"`; do
    echo "REC[${REC}]"
    ./xsl.sh -s:$REC -xsl:./fix.xsl > ${REC}.new
    mv ${REC} ${REC}.bak
    mv ${REC}.new ${REC}
done
