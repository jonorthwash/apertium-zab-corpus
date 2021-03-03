#!/bin/bash

cat BxTP/BxTP@Simp.1.txt BxTP/BxTP@Simp.2.txt > BxTP/BxTP@Simp.1-2.txt
cat BxTP/BxTP@Dict.1.txt BxTP/BxTP@Dict.2.txt > BxTP/BxTP@Dict.1-2.txt
cat BxTP/BxTP@Simp.3.txt BxTP/BxTP@Simp.4.txt BxTP/BxTP@Simp.5.txt BxTP/BxTP@Simp.6.txt > BxTP/BxTP@Simp.3-6.txt
cat BxTP/BxTP@Dict.3.txt BxTP/BxTP@Dict.4.txt BxTP/BxTP@Dict.5.txt BxTP/BxTP@Dict.6.txt > BxTP/BxTP@Dict.3-6.txt
cat FHL-poetry/*.txt > FHL-poetry/FHL-poetry.all.txt

coverage-hfst BxTP/BxTP@Simp.1-2.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst BxTP/BxTP@Dict.1-2.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst BxTP/BxTP@Simp.3-6.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst BxTP/BxTP@Dict.3-6.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst FHL-poetry/FHL-poetry.all.txt ../apertium-zab/zab.automorf.hfst

Simp12line=$(grep 'BxTP@Simp.1-2.txt' history.log | tail -n1)
Dict12line=$(grep 'BxTP@Dict.1-2.txt' history.log | tail -n1)
Simp36line=$(grep 'BxTP@Simp.3-6.txt' history.log | tail -n1)
Dict36line=$(grep 'BxTP@Dict.3-6.txt' history.log | tail -n1)
FHLline=$(grep 'FHL-poetry.all.txt' history.log | tail -n1)

Simp12cov=$(echo "$Simp12line" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
Dict12cov=$(echo "$Dict12line" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
Simp36cov=$(echo "$Simp36line" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
Dict36cov=$(echo "$Dict36line" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
FHLcov=$(echo "$FHLline" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )

Simp12toks=$(echo "$Simp12line" | cut -f2 | sed 's/.*\///' )
Dict12toks=$(echo "$Dict12line" | cut -f2 | sed 's/.*\///' )
Simp36toks=$(echo "$Simp36line" | cut -f2 | sed 's/.*\///' )
Dict36toks=$(echo "$Dict36line" | cut -f2 | sed 's/.*\///' )
FHLtoks=$(echo "$FHLline" | cut -f2 | sed 's/.*\///' )


#echo $(bc -l <<< "scale=2; $Dict12cov*100")
#echo $(echo 'scale=2;'"$Dict12cov * 100.00"| bc -l)

echo "        \emph{Blal xte Tiu Pamyël} 1-2 & Simple & $Simp12toks & $(printf %.2f $Simp12cov) \\\\"
echo "         & Dictionary & $Dict12toks & $(printf %.2f $Dict12cov) \\\\"
echo "        \emph{Blal xte Tiu Pamyël} 3-6 & Simple & $Simp36toks & $(printf %.2f $Simp36cov) \\\\"
echo "         & Dictionary & $Dict36toks & $(printf %.2f $Dict36cov) \\\\"
echo "        Felipe H. Lopez poetry & Simple & $FHLtoks & $(printf %.2f $FHLcov) \\\\"
