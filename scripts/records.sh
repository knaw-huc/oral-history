#!/bin/bash

IN="/Users/menzowi/Documents/Projects/VLB/scans/microfiches/V4/cmdi/"
OUT="/Users/menzowi/Documents/Projects/VLB/backup/records-20231022/inprogress/"
EXT="xml"
CREATOR="records.sh"
DATE="2023-10-23"

for REC in `find ${IN} -type f -name "*.${EXT}"`; do
    echo "REC[${REC}]"
    I="1"
    while [ -d ${OUT}/md${I} ]; do
        I=`expr $I + 1`
    done
    echo "MD[${OUT}/md${I}]"
    mkdir -p ${OUT}/md${I}/metadata
    mkdir -p ${OUT}/md${I}/resources
    ./xsl.sh -s:$REC -xsl:./strip.xsl > ${OUT}/md${I}/metadata/record-1.2.cmdi
    xsltproc ./cmd-record-1_2-to-1_1.xsl ${OUT}/md${I}/metadata/record-1.2.cmdi > ${OUT}/md${I}/metadata/record.cmdi
    echo "INSERT INTO metadata_records(id,name,profile_id,creator,creation_date) VALUES(${I},\"rec ${I}\",1,\"${CREATOR}\",\"${DATE}\");" >> /Users/menzowi/Documents/Projects/VLB/backup/records-20231022/records-V4.sql
done
