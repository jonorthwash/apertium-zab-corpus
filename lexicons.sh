#!/usr/bin/env bash

TRANSLITERATOR=../apertium-zab/apertium-zab.zab.lexd

counts=$(lexd -x $TRANSLITERATOR 2>&1 > /dev/null)


#echo $counts
IrregVStems=17;  # manually counted
MiscToRemove=7;  # V-Neg(1), V-Extender(1), Aspect(4), N-Poss(1)

NPstems=$(echo $counts | grep -Eo "NP-Stems: [0-9]+" | cut -f2 -d' ')
Nstems=$(echo $counts | grep -Eo "N-Stems: [0-9]+" | cut -f2 -d' ')
NPossstems=$(echo $counts | grep -Eo "N-Stems-Possessed: [0-9]+" | cut -f2 -d' ')
Vstems=$(echo $counts | grep -Eo "V-Stems: [0-9]+" | cut -f2 -d' ')
VstemsI=$(echo $counts | grep -Eo "V-Stems-Irreg: [0-9]+" | cut -f2 -d' ')
VstemsIA=$(echo $counts | grep -Eo "V-Stems-IrregAspect: [0-9]+" | cut -f2 -d' ')
Prepstems=$(echo $counts | grep -Eo "Prep-Stems: [0-9]+" | cut -f2 -d' ')
PrepWstems=$(echo $counts | grep -Eo "Prep-Stems-WPron: [0-9]+" | cut -f2 -d' ')
PrnBound=$(echo $counts | grep -Eo "Prn-Bound: [0-9]+" | cut -f2 -d' ')
Pronouns=$(echo $counts | grep -Eo "Pronouns: [0-9]+" | cut -f2 -d' ')
Advstems=$(echo $counts | grep -Eo "Adv-Stems: [0-9]+" | cut -f2 -d' ')
AdvIstems=$(echo $counts | grep -Eo "Adv-Stems-Itg: [0-9]+" | cut -f2 -d' ')
Numbers=$(echo $counts | grep -Eo "Number-Stems: [0-9]+" | cut -f2 -d' ')
Conjstems=$(echo $counts | grep -Eo "Conjunctions: [0-9]+" | cut -f2 -d' ')
Aux=$(echo $counts | grep -Eo "Aux: [0-9]+" | cut -f2 -d' ')
Punct=$(echo $counts | grep -Eo "Punctuation: [0-9]+" | cut -f2 -d' ')

ModStems=$(echo $counts | grep -Eo "Mod-Stems: [0-9]+" | cut -f2 -d' ')
IjStems=$(echo $counts | grep -Eo "Ij-Stems: [0-9]+" | cut -f2 -d' ')
AdjStems=$(echo $counts | grep -Eo "Adj-Stems: [0-9]+" | cut -f2 -d' ')
DetStems=$(echo $counts | grep -Eo "Det-Stems: [0-9]+" | cut -f2 -d' ')
PostdetStems=$(echo $counts | grep -Eo "Postdet-Stems: [0-9]+" | cut -f2 -d' ')

Anon=$(echo $counts | grep -Eo "All anonymous lexicons: [0-9]+" | cut -f2 -d':')
Entries=$(echo $counts | grep -Eo "Lexicon entries: [0-9]+" | cut -f2 -d':')

NstemsTot=$(echo $Nstems"+"$NPossstems | bc);
VstemsTot=$(echo $Vstems"+"$IrregVStems | bc);
PrepstemsTot=$(echo $Prepstems"+"$PrepWstems | bc);
PronstemsTot=$(echo $PrnBound"+"$Pronouns | bc);
AdvstemsTot=$(echo $Advstems"+"$AdvIstems | bc);
MiscTot=$(echo $ModStems"+"$IjStems"+"$AdjStems"+"$DetStems"+"$PostdetStems | bc);
Total=$(echo $Entries"-"$Anon"-"$MiscToRemove"-"$VstemsI"-"$VstemsIA"+"$IrregVStems | bc);



echo "        Proper nouns & $NPstems \\\\";
echo "        Nouns & $NstemsTot \\\\";
echo "        Verbs & $VstemsTot \\\\";
echo "        Pronouns & $PronstemsTot \\\\";
echo "        Complex verb elements & $Aux \\\\";
echo "        Adverbs & $AdvstemsTot \\\\";
echo "        Punctuation & $Punct \\\\";
echo "        Numbers & $Numbers \\\\";
echo "        Prepositions & $PrepstemsTot \\\\";
echo "        Conjunctions & $Conjstems \\\\";
echo "        Interjections, modal particles, adjs, dets & $MiscTot \\\\";
echo "    \\midrule";
echo "        total & $Total \\\\";


