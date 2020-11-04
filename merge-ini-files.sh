#!/bin/bash
# ./merge.sh specific.ini global.ini config.ini
# WIP

cat $1 > tmp0
cat $2 >> tmp0
cat $3 >> tmp0
awk -F "=" '!a[$1]++' tmp0 > tmp1 && mv tmp1 final.ini && rm tmp0
