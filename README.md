# MRDX2_TIMBuilder
A PNG Export/Import tool to edit existing TIM files for MRDX2.


## Usage Preparation
Once you have extracted the data.bin folder of MRDX2, navigate to the following folder:
\mfdx\MF2\Resources\data\mf2\data\mon

Monsters are contained within each of the following folder names:
kapi - Pixie
kbdr - Dragon
kckn - Centaur
kdro - ColorPandora
kebe - Beaclon
kfhe - Henger
khcy - Wracky
kigo - Golem
kkro - Zuum
klyo - Durahan
kmto - Arrow Head
marig - Tiger
mbhop - Hopper
mcham - Hare
mdbak - Baku
megar - Gali
mfakr - Kato
mggjr - Zilla
mhlam - Bajarl
minya - Mew
mjfbd - Phoenix
mkgho - Ghost
mlspm - Metalner
mmxsu - Suezo
mnsnm - Jill
mochy - Mocchi
mpjok - Joker
mqnen - Gaboo
mrpru - Jell
msund - Undine
mtgai - Niton
muoku - Mock
mvdak - Ducken
mwpla - Plant
mxris - Monol
mylau - Ape
mzmus - Worm
naaga - Naga

Grab the .tex file inside. Each monster has two primary texture files and are named using the following format: 
main_sub.tex
main_sub_bt.tex

The primary main_sub.tex file is for the monster's appearance itself.
The file ending in _bt.tx is used for battle sprites and the monster splash image just before combat begins.

As an example, Zilla/Pixie's file is named mg_ka.tex
Breed identifiers are as follows:
ka - Pixie
kb - Dragon
kc - Centaur
kd - ColorPandora
ke - Beaclon
kf - Henger
kh - Wracky
ki - Golem
kk - Zuum
kl - Durahan
km - Arrow Head
ma - Tiger
mb - Hopper
mc - Hare
md - Baku
me - Gali
mf - Kato
mg - Zilla
mh - Bajarl
mi - Mew
mj - Phoenix
mk - Ghost
ml - Metalner
mm - Suezo
mn - Jill
mo - Mocchi
mp - Joker
mq - Gaboo
mr - Jell
ms - Undine
mt - Niton
mu - Mock
mv - Ducken
mw - Plant
mx - Monol
my - Ape
mz - Worm
na - Naga

## Tool Usage
Go to https://github.com/ArchbishopDave/MRDX2_TIMBuilder/releases/ and download the latest .zip file
Extract the contents of the zip file into a folder
Open MRDX2_TIMBuilder.exe
Click on Import TIM and select the file in step 2
Click on Export PNG you will get a PNG file like this (I'm using Zilla/Zilla in this example)
Use an image editing tool to edit the PNG file
Go back to the MRDX2_TIMBuilder and click Import PNG
Wait 10-15 seconds - This step may take longer depending on the size of the image and computer specs.
Click Export TIM
Replace the original tex files from the preparation step with the .tex files from MRDX2_TIMBuilder
Generate the monster in MRDX2 and enjoy!
