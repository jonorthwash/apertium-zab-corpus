#!/bin/bash

cat BxTP/BxTP@Simp.1.txt BxTP/BxTP@Simp.2.txt > BxTP/BxTP@Simp.1-2.txt
cat BxTP/BxTP@Dict.1.txt BxTP/BxTP@Dict.2.txt > BxTP/BxTP@Dict.1-2.txt
cat BxTP/BxTP@Simp.3.txt BxTP/BxTP@Simp.4.txt > BxTP/BxTP@Simp.3-4.txt
cat BxTP/BxTP@Dict.3.txt BxTP/BxTP@Dict.4.txt > BxTP/BxTP@Dict.3-4.txt
cat BxTP/BxTP@Simp.3.txt BxTP/BxTP@Simp.4.txt BxTP/BxTP@Simp.5.txt BxTP/BxTP@Simp.6.txt BxTP/BxTP@Simp.7.txt > BxTP/BxTP@Simp.3-7.txt
cat BxTP/BxTP@Dict.3.txt BxTP/BxTP@Dict.4.txt BxTP/BxTP@Dict.5.txt BxTP/BxTP@Dict.6.txt > BxTP/BxTP@Dict.3-6.txt

rm FHL-poetry/FHL-poetry.all.txt Tlalocan/Tlalocan@Dict.all.txt Tlalocan/Tlalocan@Simp.all.txt */*Simp-Dict* */*Dict-Simp*
cat FHL-poetry/*.txt > FHL-poetry/FHL-poetry.all.txt
cat Tlalocan/*@Simp* > Tlalocan/Tlalocan@Simp.all.txt
cat Tlalocan/*@Dict* > Tlalocan/Tlalocan@Dict.all.txt

rm ALL.txt
cat BxTP/BxTP@Simp.1-2.txt BxTP/BxTP@Dict.1-2.txt BxTP/BxTP@Simp.3-7.txt BxTP/BxTP@Dict.3-6.txt FHL-poetry/FHL-poetry.all.txt Tlalocan/Tlalocan@Dict.all.txt Tlalocan/Tlalocan@Simp.all.txt Ticha/2020-07-17.txt misc/ninybac.txt misc/liazachaa.txt UDHR/udhr@Simp.txt UDHR/udhr@Dict.txt > ALL.txt

coverage-hfst BxTP/BxTP@Simp.1-2.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst BxTP/BxTP@Dict.1-2.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst BxTP/BxTP@Simp.3-7.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst BxTP/BxTP@Dict.3-6.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst FHL-poetry/FHL-poetry.all.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst Tlalocan/Tlalocan@Simp.all.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst Tlalocan/Tlalocan@Dict.all.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst Bible/SJGZ.bible.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst Ticha/2020-07-17.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst misc/ninybac.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst misc/liazachaa.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst UDHR/udhr@Simp.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst UDHR/udhr@Dict.txt ../apertium-zab/zab.automorf.hfst
coverage-hfst ALL.txt ../apertium-zab/zab.automorf.hfst

Simp12line=$(grep 'BxTP@Simp.1-2.txt' history.log | tail -n1)
Dict12line=$(grep 'BxTP@Dict.1-2.txt' history.log | tail -n1)
Simp37line=$(grep 'BxTP@Simp.3-7.txt' history.log | tail -n1)
Dict36line=$(grep 'BxTP@Dict.3-6.txt' history.log | tail -n1)
FHLline=$(grep 'FHL-poetry.all.txt' history.log | tail -n1)
SimpTlalocan=$(grep 'Tlalocan@Simp.all.txt' history.log | tail -n1)
DictTlalocan=$(grep 'Tlalocan@Dict.all.txt' history.log | tail -n1)
bibleSJGZ=$(grep 'SJGZ.bible.txt' history.log | tail -n1)
TichaPost=$(grep '2020-07-17.txt' history.log | tail -n1)
NinyBac=$(grep 'ninybac.txt' history.log | tail -n1)
LiazaChaa=$(grep 'liazachaa.txt' history.log | tail -n1)
UDHRSimp=$(grep 'udhr@Simp.txt' history.log | tail -n1)
UDHRDict=$(grep 'udhr@Dict.txt' history.log | tail -n1)
All=$(grep 'ALL.txt' history.log | tail -n1)

Simp12cov=$(echo "$Simp12line" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
Dict12cov=$(echo "$Dict12line" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
Simp37cov=$(echo "$Simp37line" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
Dict36cov=$(echo "$Dict36line" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
FHLcov=$(echo "$FHLline" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
SimpTlcov=$(echo "$SimpTlalocan" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
DictTlcov=$(echo "$DictTlalocan" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
bibleSJGZcov=$(echo "$bibleSJGZ" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
TichaPostcov=$(echo "$TichaPost" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
NinyBaccov=$(echo "$NinyBac" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
LiazaChaacov=$(echo "$LiazaChaa" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
UDHRSimpcov=$(echo "$UDHRSimp" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
UDHRDictcov=$(echo "$UDHRDict" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )
Allcov=$(echo "$All" | cut -f3 | sed 's/~//' | sed 's/$/*100/' | bc )

Simp12toks=$(echo "$Simp12line" | cut -f2 | sed 's/.*\///' )
Dict12toks=$(echo "$Dict12line" | cut -f2 | sed 's/.*\///' )
Simp37toks=$(echo "$Simp37line" | cut -f2 | sed 's/.*\///' )
Dict36toks=$(echo "$Dict36line" | cut -f2 | sed 's/.*\///' )
FHLtoks=$(echo "$FHLline" | cut -f2 | sed 's/.*\///' )
SimpTltoks=$(echo "$SimpTlalocan" | cut -f2 | sed 's/.*\///' )
DictTltoks=$(echo "$DictTlalocan" | cut -f2 | sed 's/.*\///' )
bibleSJGZtoks=$(echo "$bibleSJGZ" | cut -f2 | sed 's/.*\///' )
TichaPosttoks=$(echo "$TichaPost" | cut -f2 | sed 's/.*\///' )
NinyBactoks=$(echo "$NinyBac" | cut -f2 | sed 's/.*\///' )
LiazaChaatoks=$(echo "$LiazaChaa" | cut -f2 | sed 's/.*\///' )
UDHRSimptoks=$(echo "$UDHRSimp" | cut -f2 | sed 's/.*\///' )
UDHRDicttoks=$(echo "$UDHRDict" | cut -f2 | sed 's/.*\///' )
Alltoks=$(echo "$All" | cut -f2 | sed 's/.*\///' )


#echo $(bc -l <<< "scale=2; $Dict12cov*100")
#echo $(echo 'scale=2;'"$Dict12cov * 100.00"| bc -l)

echo "        development & \emph{Blal xte Tiu Pamyël} 1-2 & Simple & $Simp12toks & $(printf %.2f $Simp12cov) \\\\"
echo "         & & Phonemic & $Dict12toks & $(printf %.2f $Dict12cov) \\\\\\midrule"
echo "        testing & \emph{Blal xte Tiu Pamyël} 3-7 & Simple & $Simp37toks & $(printf %.2f $Simp37cov) \\\\"
echo "        & \emph{Blal xte Tiu Pamyël} 3-4 & Phonemic & $Dict36toks & $(printf %.2f $Dict36cov) \\\\"
echo "        & Felipe H. Lopez poetry & Simple & $FHLtoks & $(printf %.2f $FHLcov) \\\\"
echo "        & Tlalocan poems \\& story & Simple & $SimpTltoks & $(printf %.2f $SimpTlcov) \\\\"
echo "        & & Tentative & $DictTltoks & $(printf %.2f $DictTlcov) \\\\"
echo "        & Niny Bac & Simple & $NinyBactoks & $(printf %.2f $NinyBaccov) \\\\"
echo "        & Liaza Chaa & Simple & $LiazaChaatoks & $(printf %.2f $LiazaChaacov) \\\\"
echo "        & Ticha post 2020-07-17 & Simple & $TichaPosttoks & $(printf %.2f $TichaPostcov) \\\\"
echo "        & UDHR (9 articles) & Simple & $UDHRSimptoks & $(printf %.2f $UDHRSimpcov) \\\\"
echo "        & UDHR (complete) & Phonemic & $UDHRDicttoks & $(printf %.2f $UDHRDictcov) \\\\"
echo "        & SJGZ Bible & SJGZ & $bibleSJGZtoks & $(printf %.2f $bibleSJGZcov) \\\\"
echo "    \midrule"
echo "        & SLQZ total & mixed & $Alltoks & $(printf %.2f $Allcov) \\\\"
