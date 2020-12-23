#!/bin/bash
  
if [ $# -lt 2 ]
then
    echo "usage: $0 <qrels> <res>"
    exit
fi

QREL=$1
RESFILE=$2

awk 'FNR==NR { repqid[$1]=$0; next } { if ($4>0) { reldocs[$1] = reldocs[$1]" "$3;} } END { \
for (i in repqid) { \
	merged_rels=""; \
	split(repqid[i], qids, " "); \
	for (j in qids) \
		merged_rels=merged_rels" "reldocs[qids[j]]; \
	n=split(merged_rels,docids," "); \
	for (k=1;k<=n;k++) \
		uniqdocs[docids[k]]=1; \
	for (uniqdoc in uniqdocs) \
		printf("%s\tQ0\t%s\t1\n", i, uniqdoc); \
	delete uniqdocs; \
} \
}' equiv.txt $QREL > $QREL.merged

trec_eval $QREL.merged $RESFILE
