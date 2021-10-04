#!/usr/bin/env bash

# Read csv file containing latin (scientific) name and the corresponding common english name

# To convert the original file without 3rd column (full name):
# cat resources/latin2english2.csv | perl -ne 'if (/\s*(\S+)\s+(\S+).*,(\S+\s\S*\s*\S*\n)/) { print "$1 $2,$3" }' | grep -v ',NA' > dictionary.csv


printf "Initializing latin-to-english and english-to-latin dictionaries of species names..."
# Make species dictionary from latin to english 

# Make declarative array

declare -A latin2english
declare -A english2latin

while read line
do
	latin=$(echo $line | cut -d ',' -f1)
	english=$(echo $line | cut -d ',' -f2) 
	latin2english[$latin]=$english # assign latin key to english value
        english2latin[$english]=$latin # assign english key to latin name
	#echo "$latin="
        #echo ${myDict[${latin}]}
done < resources/dictionary.csv


if [ ${english2latin['Carrot']+_} ]; then echo "Found ${english2latin['Carrot']}"; else echo "Not found"; fi
if [ ${english2latin['Cardfdfrot']+_} ]; then echo "Found ${english2latin['Cardfdfrot']}"; else echo "Not found ${english2latin['Cardfdfrot']}"; fi
if [ ${latin2english['Mus musculus']+_} ]; then echo "Found ${latin2english['Mus musculus']}"; else echo "Not found ${latin2english['Mus musculus']}"; fi
if [ ${latin2english['Mccus mdcdcdcdcusculus']+_} ]; then echo "Found"; else echo "Not found"; fi

echo " DONE"
