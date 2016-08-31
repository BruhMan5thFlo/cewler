#!/bin/sh

clear

if [ -z "$1" ]; then

echo "___________________________________________________________________"
echo "                                                                   \\"
echo " ::::::::: #########::: ########::: #::::#::::::#::: #::::::::::::::"
echo " ::::::::: #::::::::::: #:::::::::: #:::##:::::#:::: #::::::::::::::"
echo " ::::::::: #::::::::::: ######::::: #::#::#:::#::::: #::::::::::::::"
echo " ::::::::: #::::::::::: #:::::::::: #:#::::#:#:::::: #::::::::::::::"
echo " ::::::::: #########::: ########::: #:::::::#::::::: #######::::::::"
echo " :::::::::.........::::.........:::....::::...::::::........::::::::"
echo "___________________________________________________________________/"
echo ""
echo "-------------------------------------------------------------------"
echo "         Credit to https://digi.ninja/   @digininja                "
echo "-------------------------------------------------------------------"
echo ""
echo "  This will run DigiNinjas cewl tool, and create a combo wordlist  "
echo "  in originally cralwed, all upper and lower-case output. Files    "
echo "  will be stored in '/cewl-lists/' wherever this is run."
echo ""	
echo "  This will also prompt to run rsmangler for mangled and DNS lists."
echo ""
echo "-------------------------------------------------------------------"
echo ""
echo "    Usage Example: # cewler.sh <target-website.com>            "
echo ""
echo "-------------------------------------------------------------------"
echo ""
echo ""
exit
fi

if [ -n "$1" ]; then
	mkdir -p cewl-lists mangled-lists dns-only
x="$1"
echo "$x"
y=$(echo $x | sed -r 's/[\/%{}:]//g' )
##echo "Cleaned? $y"

###     -m is min word len -d is depth to spider (more than one will take a while!)
	cewl -m 1 -d 1 -w "$y.combo" --ua "Mozilla/5.0 Gecko/20100101 Firefox/43.0 Iceweasel/43.0.4" $1

	tr "[:upper:]" "[:lower:]" < "$y.combo" > "$y.combo.old"
	cat "$y.combo.old" | sed 's/ //g' > "$y.combo.lower"
	tr  "[:lower:]" "[:upper:]" < "$y.combo.lower" > "$y.combo.upper"
	cat "$y.combo.lower" "$y.combo.upper" "$y.combo" > "$y.combo.txt"
	rm "$y.combo.old" "$y.combo" "$y.combo.lower" "$y.combo.upper"
	echo "Combined WordList: $y.combo.txt"
	mv "$y.combo.txt" cewl-lists/
	wc ./cewl-lists/$y.combo.txt

echo "-------------------------------------------------------------------"
echo "-------------------------------------------------------------------"
echo "      Do you want to run this through rsmangler as well? [y][n]    "
echo ""
read answer

if [ -n "$answer" ] && [ "$answer" = "y" ]; then

	if [ -f ./mangled-lists/$y.mangled.combo.txt ]; then
		rm ./mangled-lists/$y.mangled.combo.txt
	fi

echo "Now running mangler for $1  ...go grab a coffee...this could be a while."
##Dont run with permutations on, will kill it.
time unbuffer rsmangler -r -t -T -c -u -l -s -e -i -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt > mangled-lists/$y.mangled.txt
echo "Double Done"

time unbuffer rsmangler -d -t -T -c -u -l -s -e -i -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt >> mangled-lists/$y.mangled.txt

echo "Reverse Done"

time unbuffer rsmangler -d -r -t -c -u -l -s -e -i -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt > mangled-lists/$y.mangled.txt

echo "l33t Done"

time unbuffer rsmangler -d -r -t -T -u -l -s -e -i -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt >> mangled-lists/$y.mangled.txt

echo "Capitalize Done"


time unbuffer rsmangler -d -r -t -T -c -u -l -e -i -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt >> mangled-lists/$y.mangled.txt

echo "Case Swap Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -i -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt >> mangled-lists/$y.mangled.txt

echo "ed Added To Word Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -y -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt >> mangled-lists/$y.mangled.txt

echo "ing Added To Word Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -a -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt >> mangled-lists/$y.mangled.txt

echo "Year(s) Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -y -C --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt >> mangled-lists/$y.mangled.txt

echo "Acronyms Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -y -a --pna --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt >> mangled-lists/$y.mangled.txt

echo "Common: admin sys pwd pw Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -y -a -C --pnb --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt >> mangled-lists/$y.mangled.txt

echo "1-9 Suffix Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -y -a -C --pna --na --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt >> mangled-lists/$y.mangled.txt

echo "1-9 Prefix Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -y -a -C --pna --pnb --nb --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt >> mangled-lists/$y.mangled.txt

echo "123 Suffix Done"

time unbuffer rsmangler -d -r -t -T -c -u -l -s -e -i -y -a -C --pna --pnb --na --punctuation -x 30 -m 2 --space --perm --force --file ./cewl-lists/$y.combo.txt >> mangled-lists/$y.mangled.txt

echo "123 Prefix Done"

cat ./cewl-lists/$y.combo.txt ./mangled-lists/$y.mangled.txt | sort -u >> mangled-lists/$y.mangled.combo.txt
rm ./mangled-lists/$y.mangled.txt

echo "If you can read this, we're done. Otherwise, I died in processing...."
wc ./mangled-lists/$y.mangled.combo.txt

echo "-------------------------------------------------------------------------------"
echo "          Do you want a unique list for DNS subcomain bruting as well? [y][n]"
read answer2

	if [ -n "$answer2" ] && [ "$answer2" = "y" ]; then
		tr "[:upper:]" "[:lower:]" < ./mangled-lists/$y.mangled.combo.txt > dns
		cat dns | sort -u > ./dns-only/$y.mangled.combo.dns.txt
		rm dns
		wc ./dns-only/$y.mangled.combo.dns.txt
	else
    echo "Exiting.."
    	exit
    fi

else 

echo "Exiting.."
	fi
fi

