grep -A6 "<num>" topics_trec_formatted.txt |grep -v "<title>"|grep -v "<desc>"|awk '{if (NF>1) print $0}'|sed 's/<num>//g'|sed 's/<\/num>//g'|awk '{if (NF==1) {b=$1; s=1;} else if (s==1) {print b"\t"$0; s=0; }}' | sort -k2 |awk -F '\t' '{if ($2!=p) {print b; b="";} b=b" "$1; p=$2}'
