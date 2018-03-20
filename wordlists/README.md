# Wordlist generator

## get_words_from_wikidictionary.sh

### Description
Simple script to get words from specific category in wiktionary.org.
It also replace words to lowercase, remove polish characters, duplicates, spaces. Words must have at least 4 and no more that 14 characters.

### Usage
Change 4 variables for your needs:
```bash
output_file=wiki.dic
pagefrom="a_battuta"    # first word to start from
base_url="https://pl.wiktionary.org"
index_url="/w/index.php?title=Kategoria:polski_(indeks)"
```

## mutate_years_l33t_append_0-000.sh

### Description
Using john.local.conf, generate words which are:
1. l33t
2. appended years 1939 - 2029
3. appended one to three digit or special character
4. change first character to uppercase

### Usage
`mutate_years_l33t_append_0-000.sh input_wordlist`

## mutate_years_l33t_append_0-00.sh

### Description
Using john.local.conf, generate words which are:
1. l33t
2. appended years 1939 - 2029
3. appended one to two digit or special character
4. change first character to uppercase

### Usage
`mutate_years_l33t_append_0-000.sh input_wordlist`

## mutate_l33t_append_000.sh

### Description
Using john.local.conf, generate words which are:
1. l33t
2. appended three digit or special character
3. change first character to uppercase

### Usage
`mutate_years_l33t_append_0-000.sh input_wordlist`

## john.local.conf

### Description
John config file with custom rules. I create following rules:
1. netr_cap:
   1. word -> word // pass lowercase word
   2. word -> Words
2. netr_years:
   1. word -> word1939 - word2029
   2. word -> word1939! - word2029!
3. netr_append_0-00:
   1. word -> word[0-9spec]
   2. word -> word[spec][0-9]
   3. word -> word[0-9][spec]
   4. word -> word[spec][0-9][0-9]
   5. word -> word[0-9][0-9][spec]
4. netr_append_000:
   1. word -> word[spec][0-9][0-9][0-9]
   2. word -> word[0-9][0-9][0-9][spec]
5. netr_append_0-000:   // netr_append_0-00 and netr_append_0-000
   1. word -> word[0-9spec]
   2. word -> word[spec][0-9]
   3. word -> word[0-9][spec]
   4. word -> word[spec][0-9][0-9]
   5. word -> word[0-9][0-9][spec]
   6. word -> word[spec][0-9][0-9][0-9]
   7. word -> word[0-9][0-9][0-9][spec]
6. netr_l33t_step1 to netr_l33t_step7:  
Make all permutation max 4 chars, eg for 'e':  
eeee, 3eee, e3ee, ee3e, eee3, 33ee, 3e3e, 3ee3, ee33, e33e, e3e3, 333e, e333, 3333.  
   1. e -> 3
   2. s -> 5
   3. i -> 1
   4. i -> !
   5. o -> 0
   6. a -> 4
   7. a -> @
