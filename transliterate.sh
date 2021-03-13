#!/usr/bin/env bash


TRANSLITERATOR_SD_SRC=../apertium-zab/.deps/zab@Simp-zab@Dict.hfst
TRANSLITERATOR_SD=../apertium-zab/zab.Simp-Dict.hfst
TRANSLITERATOR_DS_SRC=../apertium-zab/.deps/zab@Dict-zab@Simp.hfst
TRANSLITERATOR_DS=../apertium-zab/zab.Dict-Simp.hfst
hfst-fst2fst -O $TRANSLITERATOR_SD_SRC -o $TRANSLITERATOR_SD
hfst-fst2fst -O $TRANSLITERATOR_DS_SRC -o $TRANSLITERATOR_DS

CORPORA="./BxTP/BxTP@Simp.1-2.txt ./BxTP/BxTP@Simp.3-4.txt ./Tlalocan/Tlalocan@Simp.all.txt"

declare -A RESULTS

for CORPUS in $CORPORA; do
	SIMPDICT=$(echo $CORPUS | sed 's/Simp/Simp-Dict/');
	DICT=$(echo $CORPUS | sed 's/Simp/Dict/');
	CORPUSNAME=$(echo $CORPUS | sed -r 's/.*\/(.+)\.txt/\1/' | sed -e 's/\@Simp//;s/\.//g');
	
	cat $CORPUS | hfst-proc $TRANSLITERATOR_SD | perl -pe 's:\/.+?\$:\$:g' | hfst-proc -n -N1 $TRANSLITERATOR_SD | sed -r "s/ʼ/\'/g" | sed -r 's/꞉/:/g' > $SIMPDICT

	RESULT=$(apertium-eval-translator-line -r $DICT -t $SIMPDICT 2> /dev/null);
	RESULTS["$CORPUSNAME-SD"]=$(echo $RESULT | sed -r 's/.*WER\): ([0-9\.]+?) \%.*/\1/')
done;


for CORPUS in $CORPORA; do
	DICTSIMP=$(echo $CORPUS | sed 's/Simp/Dict-Simp/');
	DICTSIMPS=$(echo $CORPUS | sed 's/Simp/Dict-SimpS/');
	DICT=$(echo $CORPUS | sed 's/Simp/Dict/');
	CORPUSNAME=$(echo $CORPUS | sed -r 's/.*\/(.+)\.txt/\1/' | sed -e 's/\@Simp//;s/\.//g');


	cat $DICT | hfst-proc $TRANSLITERATOR_DS | perl -pe 's:\/.+?\$:\$:g' | hfst-proc -n -N1 $TRANSLITERATOR_DS | sed -r "s/ʼ/\'/g" | sed -r 's/꞉/:/g' > $DICTSIMP

	RESULT=$(apertium-eval-translator-line -r $CORPUS -t $DICTSIMP 2> /dev/null);
	RESULTS["$CORPUSNAME-DS"]=$(echo $RESULT | sed -r 's/.*WER\): ([0-9\.]+?) \%.*/\1/')

#'s/([aeiouë])h([^aáàeéèiíìoóòuúùë])/\1\2/g'
	cat $DICT | sed -r 's/([aeiouë])h/\1/ig' | sed "s|[\'ʼ:꞉-]||g" | sed -re 's/[áà]/a/g;s/[éè]/e/g;s/[íì]/i/g;s/[óò]/o/g;s/[úù]/u/g' | sed -re 's/a+/a/g;s/e+/e/g;s/i+/i/g;s/o+/o/g;s/u+/u/g;s/l+/l/g;s/m+/m/g;s/n+/n/g;' > $DICTSIMPS

	RESULT=$(apertium-eval-translator-line -r $CORPUS -t $DICTSIMPS 2> /dev/null);
	RESULTS["$CORPUSNAME-DSS"]=$(echo $RESULT | sed -r 's/.*WER\): ([0-9\.]+?) \%.*/\1/')

done;

echo "           D-SS   D-S   S-D"
echo BxTP 1-2: ${RESULTS["BxTP1-2-DSS"]}  ${RESULTS["BxTP1-2-DS"]}	 ${RESULTS["BxTP1-2-SD"]}
echo BxTP 1-2: ${RESULTS["BxTP3-4-DSS"]}  ${RESULTS["BxTP3-4-DS"]}	 ${RESULTS["BxTP3-4-SD"]}
echo Tlalocan: ${RESULTS["Tlalocanall-DSS"]}  ${RESULTS["Tlalocanall-DS"]}  ${RESULTS["Tlalocanall-SD"]}
