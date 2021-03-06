#!/bin/bash

if [ $# != 1 ]; then
	echo "No wordlist"
	exit 0
fi

echo "# [1/5] Genereting $1_l33t"
john -w:$1 -ru:netr_l33t_step1 --stdout > $1_s1 2>/dev/null
for x in {2..7}; do 
	john -w:$1_s$((x-1)) -ru:netr_l33t_step$x --stdout > $1_s$x  2>/dev/null
	rm $1_s$((x-1))
done

echo "# [2/5] Genereting $1_append_000"
john -w:$1 -ru:netr_append_000 -stdout > $1_append_000 2>/dev/null
echo "# [3/5] Genereting $1_l33t_append_000"
john -w:$1_s7 -ru:netr_append_000 -stdout > $1_l33t_append_000 2>/dev/null
echo "# [4/5] Genereting $1_L33t"
john -w:$1_append_000 -ru:netr_cap -stdout > $1_Append_000 2>/dev/null
echo "# [5/5] Genereting $1_L33t_append_000"
john -w:$1_l33t_append_000 -ru:netr_cap -stdout > $1_L33t_append_000 2>/dev/null

echo "# Concatenate all"
cat $1_append_000 $1_l33t_append_000 $1_Append_000 $1_L33t_append_000 > $1_mutated_000
rm $1_append_000 $1_l33t_append_000 $1_Append_000 $1_L33t_append_000

echo "# Done! We have `wc -l $1_mutated_000` password"
