#cat ../qrel-judgement-v3.txt | awk '{if ($4>0) reldocs[$1]=reldocs[$1]" "$3} END{for (d in reldocs) print d"\t"reldocs[d]}' > tmp
#cat equiv.txt |awk '{n=split($0,a," "); for (i in a) for (j in a) e[a[i]":"a[j]]=1} END{for (k in e) print k}'
#A debug version of the last line...
#END {for (i in repqid) { print("***"repqid[i]"***"); split(repqid[i], qids, " "); for (j in qids) printf("%s: %s\n", qids[j], reldocs[qids[j]]);} }' equiv.txt ../qrel-judgement-v3.txt 

QREL=qrel-judgement-v3.txt
MERGED_QREL=qrels.merged

awk 'FNR==NR \
{repqid[$1]=$0; next} \
{if ($4>0) reldocs[$1]=reldocs[$1]" "$3} \
END {for (i in repqid) { split(repqid[i], qids, " "); for (j in qids) { n=split(reldocs[qids[j]],docids," "); for (k=1;k<=n; k++) printf("%s\tQ0\t%s\t1\n", qids[1], docids[k]);} }}' equiv.txt $QREL > $MERGED_QREL

