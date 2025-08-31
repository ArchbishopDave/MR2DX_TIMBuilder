# MRDX2\_TIMBuilder

A PNG Export/Import tool to edit existing TIM files for MRDX2.



## Version Information

### v1.1.0

* Creator Mode Added
* Sounds Added
* The tool now makes an HTTP request on startup to check for latest releases.



## Usage Preparation

Once you have extracted the data.bin folder of MRDX2, navigate to the following folder:
\\mfdx\\MF2\\Resources\\data\\mf2\\data\\mon

* Monsters are contained within each of the following folder names:
* kapi - Pixie
* kbdr - Dragon
* kckn - Centaur
* kdro - ColorPandora
* kebe - Beaclon
* kfhe - Henger
* khcy - Wracky
* kigo - Golem
* kkro - Zuum
* klyo - Durahan
* kmto - Arrow Head
* marig - Tiger
* mbhop - Hopper
* mcham - Hare
* mdbak - Baku
* megar - Gali
* mfakr - Kato
* mggjr - Zilla
* mhlam - Bajarl
* minya - Mew
* mjfbd - Phoenix
* mkgho - Ghost
* mlspm - Metalner
* mmxsu - Suezo
* mnsnm - Jill
* mochy - Mocchi
* mpjok - Joker
* mqnen - Gaboo
* mrpru - Jell
* msund - Undine
* mtgai - Niton
* muoku - Mock
* mvdak - Ducken
* mwpla - Plant
* mxris - Monol
* mylau - Ape
* mzmus - Worm
* naaga - Naga



Grab the .tex files inside. Each monster has two primary texture files and are named using the following format:
main\_sub.tex
main\_sub\_bt.tex

The primary main\_sub.tex file is for the monster's appearance itself.
The file ending in \_bt.tx is used for battle sprites and the monster splash image just before combat begins.

As an example, Zilla/Pixie's file is named mg\_ka.tex



Breed identifiers are the first two letters of the folder names above.



## Tool Usage

1. Go to https://github.com/ArchbishopDave/MRDX2\_TIMBuilder/releases/ and download the latest .zip file
2. Extract the contents of the zip file into a folder
3. Open MR2DX\_TIMBuilder.exe
4. Click on Import TIM and select the texture file you wish to use as a base.
5. Click on Export PNG you will get a PNG file like this (I'm using Zilla/Zilla in this example)
6. Use an image editing tool to edit the PNG file
7. Go back to the MR2DX\_TIMBuilder and click Import PNG. Wait for Step 6 to complete.
8. Click Export TIM
9. Replace the original tex files from the preparation step with the .tex files from MR2DX\_TIMBuilder
10. Generate the monster in MRDX2 and enjoy!



## Creator Mode Usage

With Version 1.1.0 a new 'Creator Mode' has been added. 

Before you begin using Creator Mode for a new monster, export the PNG first.



Creator mode performs the following functions and works the following way:

* Select the 'Creator Mode' option when beginning work on a monster texture file.
* Select the TEX file you wish to read and use meta data from.
* Select the PNG file you wish to import and utilize for creator mode.
* Select the output TEX file. 



Once initialized, Creator Mode will automatically import the PNG, followed by exporting the TEX file, indicated by two separate sound effects at the beginning and end of this process respectively.



While enabled, Creator Mode will periodically check the status of the selected PNG file. If any edits are made to the file, the tool will repeat this process. With this, you do not need to save your work, then use the tool to reimport and re-export the TEX file for testing purposes. The sound cue can be used to know when textures can be reloaded in MR2DX for testing!

