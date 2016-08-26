#!/bin/sh

clear

if [ -z "$1" ]; then
echo "-------------------------------------------------------------------"
echo "         Credit to https://digi.ninja/   @digininja                "
echo "-------------------------------------------------------------------"
echo ""
echo "  This will run DigiNinjas cewl tool, and create a combo wordlist  "
echo "  in originally cralwed, all upper and lower-case output. Files    "
echo "  will be stored in '/cewl-lists/' where the script is run.        "
echo "  Optionally, you can also run rsmangler for another combo list.   "
echo ""
echo "-------------------------------------------------------------------"
echo ""
echo "    Usage Example: bash cewler website.com            "
echo ""
echo "-------------------------------------------------------------------"
echo "-------------------------------------------------------------------"
echo ""
echo ""
exit
fi

if [ -n "$1" ]; then
	mkdir -p cewl-lists mangled-lists
###     -m is min word len -d is depth to spider (more than one will take a while!)
	cewl -m 3 -d 1 -w "$1.combo" --ua "Mozilla/5.0 Gecko/20100101 Firefox/43.0 Iceweasel/43.0.4" $1
	tr "[:upper:]" "[:lower:]" < "$1.combo" > "$1.combo.old"
	cat "$1.combo.old" | sed 's/ //g' > "$1.combo.lower"
	tr  "[:lower:]" "[:upper:]" < "$1.combo.lower" > "$1.combo.upper"
	cat "$1.combo.lower" "$1.combo.upper" "$1.combo" > "$1.combo.txt"
	rm "$1.combo.old" "$1.combo" "$1.combo.lower" "$1.combo.upper"
	echo "Combined WordList: $1.combo.txt"
	mv "$1.combo.txt" cewl-lists/
	wc ./cewl-lists/$1.combo.txt

echo "-------------------------------------------------------------------"
echo "-------------------------------------------------------------------"
echo "      Do you want to run this through rsmangler as well? [y][n]    "
echo ""
read answer

if [ -n "$answer" ] && [ "$answer" = "y" ]; then

	if [ -f ./mangled-lists/$1.mangled.combo.txt ]; then
		rm ./mangled-lists/$1.mangled.combo.txt
	fi

echo "Now running mangler for $1  ...go grab a coffee...this could be a while."
##Dont run with permutations on, will kill it.
time unbuffer rsmangler -r -t -T -c -u -l -s -e -i -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt > mangled-lists/$1.mangled.txt
echo "Double Done"

time unbuffer rsmangler -d -t -T -c -u -l -s -e -i -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt >> mangled-lists/$1.mangled.txt

echo "Reverse Done"

time unbuffer rsmangler -d -r -t -c -u -l -s -e -i -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt > mangled-lists/$1.mangled.txt

echo "l33t Done"

time unbuffer rsmangler -d -r -t -T -u -l -s -e -i -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt >> mangled-lists/$1.mangled.txt

echo "Capitalize Done"


time unbuffer rsmangler -d -r -t -T -c -u -l -e -i -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt >> mangled-lists/$1.mangled.txt

echo "Case Swap Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -i -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt >> mangled-lists/$1.mangled.txt

echo "ed Added To Word Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt >> mangled-lists/$1.mangled.txt

echo "ing Added To Word Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt >> mangled-lists/$1.mangled.txt

echo "Year(s) Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -y -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt >> mangled-lists/$1.mangled.txt

echo "Acronyms Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -y -a --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt >> mangled-lists/$1.mangled.txt

echo "Common: admin sys pwd pw Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -y -a -C --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt >> mangled-lists/$1.mangled.txt

echo "1-9 Suffix Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -y -a -C --pna --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt >> mangled-lists/$1.mangled.txt

echo "1-9 Prefix Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -y -a -C --pna --pnb --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt >> mangled-lists/$1.mangled.txt

echo "123 Suffix Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -y -a -C --pna --pnb --na --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$1.combo.txt >> mangled-lists/$1.mangled.txt

echo "123 Prefix Done"

cat ./cewl-lists/$1.combo.txt ./mangled-lists/$1.mangled.txt | sort -u >> mangled-lists/$1.mangled.combo.txt
rm ./mangled-lists/$1.mangled.txt

echo "Lists combined. If you can read this, we're done. Otherwise, I died in processing...."
wc ./mangled-lists/$1.mangled.combo.txt


	exit
else 

echo "Exiting.."
	fi
fi

