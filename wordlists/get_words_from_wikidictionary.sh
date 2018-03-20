#!/bin/bash

# Script gets all words from specific site, replace words to lowercase, remove polish characters and remove duplicate, spaces, words at least 4 and no more that 14 characters

function remove_pl() {
enconv -x UTF-8 -L polish "$1"

	sed 's/ą/a/g' "$1" -i
	sed 's/ę/e/g' "$1" -i
	sed 's/ż/z/g' "$1" -i
	sed 's/ź/z/g' "$1" -i
	sed 's/ł/l/g' "$1" -i
	sed 's/ó/o/g' "$1" -i
	sed 's/ś/s/g' "$1" -i
	sed 's/ć/c/g' "$1" -i
	sed 's/ń/n/g' "$1" -i
}

output_file=wiki.dic
pagefrom="a_battuta"	# first word to start from
base_url="https://pl.wiktionary.org"
index_url="/w/index.php?title=Kategoria:polski_(indeks)"

while [ ${#pagefrom} -gt 0 ]; do
	curl -s ${base_url}${index_url}"&pagefrom=${pagefrom}" | grep '^<li><a href="/wiki/' | egrep -ioe '>[a-z]+<' | tr -d '><' | sed 's/\([a-zA-Z]*\)/\L\1/' | tr -d ' ' | egrep -e '^.{4,14}$' >> ${output_file}.tmp

	pagefrom_next=$(curl -s ${base_url}${index_url}"&pagefrom=${pagefrom}" | grep -o ${index_url}"&amp;pagefrom=[A-Za-z0-9%#+-]*" | grep -oie 'pagefrom=[A-Za-z0-9%+]*' | cut -d '=' -f 2 | head -n 1)

	if [ ${pagefrom} == ${pagefrom_next} ]; then
		break
	fi

	pagefrom=${pagefrom_next}
	echo "Page from: ${pagefrom}"
done

remove_pl ${output_file}.tmp
sort -u ${output_file}.tmp > $output_file
rm ${output_file}.tmp
