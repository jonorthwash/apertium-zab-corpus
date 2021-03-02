#!/bin/bash

cat BxTP/BxTP@Dict.1.txt BxTP/BxTP@Dict.2.txt > BxTP/BxTP@Dict.1-2.txt
cat BxTP/BxTP@Simp.1.txt BxTP/BxTP@Simp.2.txt > BxTP/BxTP@Simp.1-2.txt
cat BxTP/BxTP@Simp.3.txt BxTP/BxTP@Simp.4.txt BxTP/BxTP@Simp.5.txt BxTP/BxTP@Simp.6.txt > BxTP/BxTP@Simp.3-6.txt
cat FHL-poetry/*.txt > FHL-poetry/FHL-poetry.all.txt

coverage-hfst BxTP/BxTP@Dict.1-2.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst BxTP/BxTP@Simp.1-2.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst BxTP/BxTP@Simp.3-6.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst FHL-poetry/FHL-poetry.all.txt ../apertium-zab/zab.automorf.hfst

Dict12line=$(grep 'BxTP@Dict.1-2.txt' history.log | tail -n1)
Simp12line=$(grep 'BxTP@Simp.1-2.txt' history.log | tail -n1)
Simp36line=$(grep 'BxTP@Simp.3-6.txt' history.log | tail -n1)
FHLline=$(grep 'FHL-poetry.all.txt' history.log | tail -n1)

Dict12cov=$(echo "$Dict12line" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
Simp12cov=$(echo "$Simp12line" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
Simp36cov=$(echo "$Simp36line" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
FHLcov=$(echo "$FHLline" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )

#echo $(bc -l <<< "scale=2; $Dict12cov*100")
#echo $(echo 'scale=2;'"$Dict12cov * 100.00"| bc -l)
printf %.2f $Dict12cov
printf %.2f $Simp12cov
printf %.2f $Simp36cov
printf %.2f $FHLcov
