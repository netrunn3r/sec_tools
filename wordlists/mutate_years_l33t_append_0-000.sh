#!/bin/bash

if [ $# != 1 ]; then
	echo "No wordlist"
	exit 0
fi

#echo "# Genereting $1_append_0-000"
#john -w:$1 -ru:netr_append_0-000 -stdout > $1_append_0-000
#echo "# Genereting $1_years"
#john -w:$1 -ru:netr_years -stdout > $1_years

echo "# [1/6] Genereting $1_l33t"
john -w:$1 -ru:netr_l33t_step1 --stdout > $1_s1 2>/dev/null
for x in {2..7}; do 
	john -w:$1_s$((x-1)) -ru:netr_l33t_step$x --stdout > $1_s$x  2>/dev/null
	rm $1_s$((x-1))
done

echo "# [2/6] Genereting $1_l33t_append_0-000"
john -w:$1_s7 -ru:netr_append_0-000 -stdout > $1_l33t_append_0-000 2>/dev/null
#john -w:$1_s7 -ru:netr_append_0-000_short -stdout > $1_l33t_append_0-000 2>/dev/null
echo "# [3/6] Genereting $1_l33t_years"
john -w:$1_s7 -ru:netr_years -stdout > $1_l33t_years 2>/dev/null

echo "# [4/6] Genereting $1_L33t"
john -w:$1_s7 -ru:netr_cap -stdout > $1_L33t 2>/dev/null
echo "# [5/6] Genereting $1_L33t_append_0-000"
john -w:$1_l33t_append_0-000 -ru:netr_cap -stdout > $1_L33t_append_0-000 2>/dev/null
echo "# [6/6] Genereting $1_L33t_years"
john -w:$1_l33t_years -ru:netr_cap -stdout > $1_L33t_years 2>/dev/null
#john -w:$1_append_0-000 -ru:netr_cap -stdout > $1_Append
#john -w:$1_years -ru:netr_cap -stdout > $1_Years
rm $1_s7 $1_l33t_years $1_l33t_append_0-000

#echo "# Concatenate $1_Append $1_Years"
#cat $1_Append $1_Years > $1_a1
#rm $1_Append $1_Years

#echo "# Concatenate $1_a1 $1_L33t"
#cat $1_a1 $1_L33t > $1_a2
#rm $1_a1 $1_L33t

echo "# Concatenate $1_L33t $1_L33t_append_0-000"
cat $1_L33t $1_L33t_append_0-000 > $1_a3
rm $1_L33t $1_L33t_append_0-000

echo "# Concatenate $1_a3 $1_L33t_years"
cat $1_a3 $1_L33t_years > $1_mutated
rm $1_a3 $1_L33t_years

echo "# Done! We have `wc -l $1_mutated` password"
