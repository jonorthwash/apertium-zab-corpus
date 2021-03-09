#!/usr/bin/env bash


TRANSLITERATOR_SRC=../apertium-zab/.deps/zab@Simp-zab@Dict.hfst
TRANSLITERATOR=../apertium-zab/zab.Simp-Dict.hfst
hfst-fst2fst -O $TRANSLITERATOR_SRC -o $TRANSLITERATOR

CORPORA="./BxTP/BxTP@Simp.1-2.txt ./Tlalocan/Tlalocan@Simp.all.txt"

for CORPUS in $CORPORA; do
	SIMPDICT=$(echo $CORPUS | sed 's/Simp/Simp-Dict/');
	DICT=$(echo $CORPUS | sed 's/Simp/Dict/');
	
	cat $CORPUS | hfst-proc $TRANSLITERATOR | perl -pe 's:\/.+?\$:\$:g' | hfst-proc -n -N1 $TRANSLITERATOR | sed -r "s/ʼ/\'/g" | sed -r 's/꞉/:/g' > $SIMPDICT

	apertium-eval-translator-line -r $DICT -t $SIMPDICT
done;


for CORPUS in $CORPORA; do
	DICTSIMP=$(echo $CORPUS | sed 's/Simp/Dict-Simp/');
	DICT=$(echo $CORPUS | sed 's/Simp/Dict/');

#'s/([aeiouë])h([^aáàeéèiíìoóòuúùë])/\1\2/g'
	cat $DICT | sed -r 's/([aeiouë])h/\1/ig' | sed "s|[\'ʼ:꞉]||g" | sed -re 's/[áà]/a/g;s/[éè]/e/g;s/[íì]/i/g;s/[óò]/o/g;s/[úù]/u/g' | sed -re 's/a+/a/g;s/e+/e/g;s/i+/i/g;s/o+/o/g;s/u+/u/g;s/l+/l/g;s/m+/m/g;s/n+/n/g;' > $DICTSIMP

	apertium-eval-translator-line -r $CORPUS -t $DICTSIMP
done;
