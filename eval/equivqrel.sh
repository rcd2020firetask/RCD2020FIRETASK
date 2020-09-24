#!/bin/bash
  
if [ $# -lt 2 ]
then
    echo "usage: $0 <qrel> <res>"
    exit
fi

QREL=$1
RESFILE=$2
MERGED_QREL=$QREL.merged

awk 'FNR==NR \
{repqid[$1]=$0; next} \
{if ($4>0) reldocs[$1]=reldocs[$1]" "$3} \
END {for (i in repqid) { split(repqid[i], qids, " "); for (j in qids) merged_rels=merged_rels" "reldocs[qids[j]]; n=split(merged_rels,docids," "); \
for (k=1;k<=n;k++) uniqdocs[docids[k]]=1; \
for (j in qids) { for (uniqdoc in uniqdocs) printf("%s\tQ0\t%s\t1\n", qids[j], uniqdoc); } } }' equiv.txt $QREL > $MERGED_QREL

trec_eval $MERGED_QREL $RESFILE
