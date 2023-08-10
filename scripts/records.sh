#!/bin/bash

IN="/Users/menzowi/Documents/Projects/CLARIAH/Vocabularies/Registry/vocab-registry/data/records"
OUT="/Users/menzowi/Documents/Projects/CLARIAH/Vocabularies/Registry/huc-cmdi-app/html/ccf/data/records/inprogress"
EXT="cmdi"
CREATOR="records.sh"
DATE="2023-08-07"

for REC in `find ${IN} -type f -name "*.${EXT}"`; do
    echo "REC[${REC}]"
    I="1"
    while [ -d ${OUT}/md${I} ]; do
        I=`expr $I + 1`
    done
    echo "MD[${OUT}/md${I}]"
    mkdir -p ${OUT}/md${I}/metadata
    mkdir -p ${OUT}/md${I}/resources
    ./xsl.sh -s:$REC -xsl:./strip.xsl > ${OUT}/md${I}/metadata/record.cmdi

    echo "INSERT INTO metadata_records(id,name,profile_id,creator,creation_date) VALUES(${I},\"rec ${I}\",1,\"${CREATOR}\",\"${DATE}\");" | tee -a /Users/menzowi/Documents/Projects/CLARIAH/Vocabularies/Registry/huc-cmdi-app/html/ccf/data/records/records.sql
done