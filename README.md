Diplomovka (súbory pre Windows a Linux)

<p> :+1: :pray: :e-mail: :hear_no_evil: :speak_no_evil: :see_no_evil: :blush:  

### Linux

- pre Linux nástroj funguje, ošetrené sú cesty na akomkoľvek počítači pomocou pridaných *Variables*
- pre ukážkový postup je v g.region nastavené rozlíšenie `res = 1000`, viď. 1. model
- nespúšťa sa GRASS GIS, ale nástroj PLGP je upravený tak, aby sa spustil len grafický modeler
- za všetkým stojí TRUNK verzia GRASS-u, výhodou je, že po `svn up` a `make` pre zdrojáky je použitá vždy najaktuálnejšia verzia GRASS-u
- python script PLGP.py bol testovaný pomocou prostredia *Spyder*
- výsledná (originál mapa s rozlížením `res = 10`) je uložená ako *.pack*, viď. [y-pack](https://github.com/lfurtkevicova/diplomovka/blob/master/y.pack)
- stačí iba aby sa mapa *y* nahradila mapou *ypack* a výsledok totožný s diplomovkou je možné prezentovať
- priečinok `pomocky`, viď. [pomôcky](https://github.com/lfurtkevicova/diplomovka/blob/master/y.pack) obsahuje príkladné súbory, pomocou ktorých možno reklasifikovať parametrické mapy, a tiež výslednú *y* mapu .. plus sú tam report-y o parametrických mapách
