#!/usr/bin/env bash


TRANSLITERATOR=../apertium-zab/zab.Simp-Dict.hfst

CORPORA="./BxTP/BxTP@Simp.1-2.txt"

for CORPUS in $CORPORA; do
	SIMPDICT=$(echo $CORPUS | sed 's/Simp/Simp-Dict/');
	DICT=$(echo $CORPUS | sed 's/Simp/Dict/');
	
	cat $CORPUS | hfst-proc $TRANSLITERATOR | perl -pe 's:\/.+?\$:\$:g' | hfst-proc -n -N1 $TRANSLITERATOR | sed -r "s/ʼ/\'/g" | sed -r 's/꞉/:/g' > $SIMPDICT

	apertium-eval-translator-line -r $CORPUS -t $SIMPDICT
done;
