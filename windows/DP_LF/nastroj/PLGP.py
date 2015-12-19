# SOFTVEROVY NASTROJ PLGP 
# Furtkevicova Ludmila, cast diplomovej prace
# script: okno s piatimi zalozkami, funkcie, tlacidla, modely
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
import os
import tkMessageBox
import Tkinter
import ttk
from Tkinter import *
from ttk import *
import sys
import subprocess
import ScrolledText
import tkFileDialog
from tkFileDialog import askdirectory, asksaveasfile

# trieda tykajuca sa programu GRASS GIS
class GRASS:   
    def __init__(self):
        # spustenie GRASS GIS
        grass7bin_win = r'C:\Program Files (x86)\GRASS GIS 7.0.0\grass70.bat'
        
        # definovanie GRASS DATABASE (GRASS GIS database) directory  
        # cestaL z GUI
        self.gisdb = "C:\\DP_LF"

        # SOFTVER
        grass7bin = grass7bin_win         
        # GRASS 7 a GISBASE
        startcmd = [grass7bin, '--config', 'path']
         
        p = subprocess.Popen(startcmd, shell=False,
                             stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out, err = p.communicate()
        if p.returncode != 0:
            print >>sys.stderr, "ERROR: Cannot find GRASS GIS 7 start script (%s)" % startcmd
            sys.exit(-1)
        self.gisbase = out.strip('\n\r')
         
        # premenna GISBASE a PATH
        os.environ['GISBASE'] = self.gisbase
        os.environ['PATH'] += os.pathsep + os.path.join(self.gisbase, 'extrabin')
         
        # definicia GRASS-Python environment
        gpydir = os.path.join(self.gisbase, "etc", "python")
        sys.path.append(gpydir)
         
        os.environ['GISDBASE'] = self.gisdb
        
# trieda tykajuca sa presmerovania (obsah okna do konkretneho suboru)
class Presmerovanie(object):

    def __init__(self, text_ctrl):
        self.output = text_ctrl
        
    def write(self, string):
        self.output.insert(Tkinter.END, string)

# trieda tykajuca sa pouzivatelskeho rozhrania                   
class GUI(Tkinter.Frame):
    Gobj = GRASS()
    cestaV = ""
    cestaI = ""
    cestaL = ""
    recl1 = "recl1"
    cesta = "C:\\DP_LF\\vypocet\\"
    
    # GUI
    def __init__(self,gui):
        Tkinter.Frame.__init__(self, gui)
        self.gui = gui
        self.gui.title(u"PLGP   (Ludmila Furtkevicova, 2015)             ")       
        note = Notebook(self.gui)
        
        # pat zaloziek 
        tab1 = Tkinter.Frame(note)
        tab2 = Tkinter.Frame(note)
        tab3 = Tkinter.Frame(note)
        tab4 = Tkinter.Frame(note)
        tab5 = Tkinter.Frame(note)
        
        # nastavenie stylu v zalozkach
        ttk.Style().configure('TLabelframe.Label', foreground='forest green',font="Verdana 8 bold")
        ttk.Style().configure('TButton', foreground='cadet blue',font="Helvetica 8 bold")
        ttk.Style().configure("TNotebook.Tab", foreground="dim gray",font="Helvetica 8 bold")
        
        # nastavenie popisov zaloziek        
        note.add(tab1, text = "  1. Settings  ")
        note.add(tab2, text = "  2. Parametric maps  ")
        note.add(tab3, text = "  3. Weight calculation  ")
        note.add(tab4, text = "  4. Prediction  ")
        note.add(tab5, text = "  5. Validation  ")
        note.pack()
        
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~ PRVA ZALOZKA ~~~~~~~~~~~~~~~~~~~~~~~~~
        # nastavenie ciest a tvorba potrebnych suborov pre dalsie zalozky
        
        ttk.Label(tab1, text=u" \n\nHandy software tool for geologists", anchor="s",\
        foreground="forest green", font = "Verdana 9 italic").grid(in_=tab1,column=0, row=0,\
        columnspan=7, sticky="S",padx=70, pady=17)
        ttk.Label(tab1, text=u"\nPredict landslide with GRASS GIS and Python", anchor="n",\
        foreground="dark green", font = "Verdana 13 bold").grid(in_=tab1,column=0, row=0,\
        columnspan=7, sticky="N",padx=30, pady=1)
        
        # prve podokno v ramci prvej zalozky (vstupne data)
        self.one = ttk.Labelframe(tab1, text = " 1. Input data:   ")
        self.one.grid(row=1, column=0, columnspan=2, sticky='S', padx=5, pady=5, ipadx=4,\
                 ipady=1)
        
        L21 = ttk.Label(self.one, text=" Path to folder with vector data:   ")
        L21.grid(row=2, column=0, sticky='W', pady=5)
        
        self.E21 = ttk.Entry(self.one, width=40)
        self.E21.grid(row=2, column=1, columnspan=2, sticky="WE", pady=5, padx = 5)
        
        B21 = ttk.Button(self.one, text=" Browse ...",command = self.openV)
        B21.grid(row=2, column=3, sticky='W',pady=5, padx = 2)
        
        # druhe podokno vramci prvej zalozky (nazov lokacie, epsg kod, ...)
        self.two = ttk.Labelframe(tab1, text = " 2. New LOCATION and new MAPSETs:\n ")
        self.two.grid(row=3, column=0, columnspan=2, sticky='S', padx=5, pady=5, ipadx=4,\
                 ipady=5)
        
        L10 = ttk.Label(self.two, text=" LOCATION name:   ")
        L10.grid(row=4, column=0, sticky='W', padx=5, pady = 5)
        
        self.E10 = ttk.Entry(self.two, width=30)
        self.E10.grid(row=4, column=1, columnspan=2, sticky="WE", pady=2)
        self.E10.insert(1,"Mapy")
        self.nameL = self.E10.get()       
         
        L11 = ttk.Label(self.two, text=" EPSG code:")
        L11.grid(row=5, column=0, sticky='W', padx=5, pady=2)
        
        self.E11 = ttk.Entry(self.two, width=7)
        self.E11.grid(row=5, column=1, columnspan=2, sticky="WE", pady=2)
        self.E11.insert(1,"2065")
        self.epsg = self.E11.get()        
         
        L12 = ttk.Label(self.two, text=" Path for new LOCATION:")
        L12.grid(row=6, column=0, sticky='W', padx=5, pady=2)
        
        self.E12 = ttk.Entry(self.two, width=10)
        self.E12.grid(row=6, column=1, columnspan=2, sticky="WE", pady=2)
        
        B12 = ttk.Button(self.two, text=" Browse ...",command = self.openL)
        B12.grid(row=6, column=3, sticky='W', padx=5, pady=2)
         
        L13 = ttk.Label(self.two, text=" Name of MAPSET for input data:   ")
        L13.grid(row=7, column=0, sticky='W', padx=5, pady=2)
        
        self.E13 = ttk.Entry(self.two, width=10)
        self.E13.grid(row=7, column=1, columnspan=2, sticky="WE", pady=2)
        self.E13.insert(1,"VSTUP")
        self.nameMV = self.E13.get()
         
        L14 = ttk.Label(self.two, text=" Name of MAPSET for intermediate data:    ")
        L14.grid(row=8, column=0, sticky='W', padx=5, pady=2)
        
        self.E14 = ttk.Entry(self.two, width=10)
        self.E14.grid(row=8, column=1, columnspan=2, sticky="WE", pady=2)
        self.E14.insert(1,"PM")
        self.nameMM = self.E14.get()
         
        L15 = ttk.Label(self.two, text=" Name of MAPSET for results:   ")
        L15.grid(row=9, column=0, sticky='W', padx=5, pady=2)
        
        self.E15 = ttk.Entry(self.two, width=10)
        self.E15.grid(row=9, column=1, columnspan=2, sticky="WE", pady=2)
        self.E15.insert(1,"PREDIKCIA")
        self.nameM = self.E15.get() 
        
        # tretie podokno vramci prvej zalozky (vysledky)
        self.three = ttk.Labelframe(tab1, text = " 3. Reports, reclassification rules, information about calculation:\n ")
        self.three.grid(row=10, column=0, columnspan=2, sticky='S', padx=5, pady=1, ipadx=5,\
        ipady=5)
        
        L31 = ttk.Label(self.three, text=" Path to folder for results:              ")
        L31.grid(row=11, column=0, sticky='WE', padx=5, pady=2)
        
        self.E31 = ttk.Entry(self.three, width=39)
        self.E31.grid(row=11, column=1, columnspan=2, sticky="WE", pady=2)
        
        B31 = ttk.Button(self.three, text="Browse ...",command = self.openI)
        B31.grid(row=11, column=3, sticky='W', padx=5, pady=2)
        
        # tlacidlo REFRESH na zmazanie predvolene nastavenych vstupov                       
        ttk.Button(tab1, text="REFRESH",command=self.refreshALL).grid(row=13, column=0,\
                sticky="WE", padx=5, pady=5,columnspan=1, rowspan=1)
        # tlacidlo na ukoncenie prace
        ttk.Button(tab1, text="QUIT",command=self.gEND).grid(row=13, column=1, \
            sticky='WE', padx=5, pady=5,columnspan=1, rowspan=1)
        # tlacidlo na ziskanie obsahu vyplnenych poloziek a tvorbu potrebnych suborov
        ttk.Button(tab1, text="NEXT", command=lambda: self.valueGET(self.E10.get(),\
                self.E11.get(), self.E13.get(), self.E14.get(),\
                self.E15.get())).grid(row=14, column=0, \
            sticky='WE', padx=5, columnspan=2, rowspan=1,pady=5)
        # tlacidlo ako alternativa HELP
        ttk.Button(tab1, text='INFO',command=tkMessageBox.showinfo).grid(row=12, column=0,\
                        sticky="WE", padx=5, pady=5,columnspan=1, rowspan=1)
        # tlacidlo ktorym sa da spustit prostredie GRASS GIS               
        ttk.Button(tab1, text='RUN GRASS GIS',command=self.RG).grid(row=12, column=1,\
                        sticky="WE", padx=5, pady=5,columnspan=1, rowspan=1)
            
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DRUHA ZALOZKA ~~~~~~~~~~~~~~~~~~~~~~
        # zobrazenie obsahu mapsetu PERMANENT, tvorba parametrickych map
        # zobrazenie informacii o mapach a ich prvotna reklasifikacia
        
        ttk.Label(tab2, text=u" \n\nHandy software tool for geologists", anchor="s",\
        foreground="forest green", font = "Verdana 9 italic").grid(in_=tab2,column=0, row=0,\
        columnspan=7, sticky="S",padx=70, pady=17)
        ttk.Label(tab2, text=u"\nPredict landslide with GRASS GIS and Python", anchor="n",\
        foreground="dark green", font = "Verdana 13 bold").grid(in_=tab2,column=0, row=0,\
        columnspan=7, sticky="N",padx=30, pady=1)
        
        # prve podokno vramci druhej zalozky na zobrazenie obsahu map v mapsete
        self.four = ttk.Labelframe(tab2, text = " 4. MAPSET content: " )
        self.four.grid(row=1, column=0, columnspan=2, sticky='E', padx=10, pady=5)
        
        self.txf1 = ScrolledText.ScrolledText(self.four, height = 5, width = 61) 
        self.txf1.grid(row=2, column=0,columnspan=2, rowspan=3, sticky='NS', padx=5, pady=5)
        
        ttk.Button(tab2, text='VIEW CONTENT',command = self.wrZM).grid(row=2,\
        column=1, sticky='E', padx=10, pady=5,columnspan=1, rowspan=1)
        
        # druhe podokno vramci druhej zalozky na zobrazenie info o param. mapach
        self.five = ttk.Labelframe(tab2, text = " 5. Information in TXT file: " )
        self.five.grid(row=3, column=0, columnspan=2, sticky='E', padx=10, pady=5)
        
        self.txf3 = ScrolledText.ScrolledText(self.five, height = 9, width = 61) 
        self.txf3.grid(row=4, column=0,columnspan=2, rowspan=3, sticky='NS', padx=5, pady=5)
        
        ttk.Button(tab2, text='INFO',command=self.showexample).grid(row=7, column=0,\
                        sticky="WE", padx=5, pady=5,columnspan=1, rowspan=1)
                        
        ttk.Button(tab2, text='RUN GRASS GIS',command=self.RG).grid(row=8, column=0,\
                        sticky="WE", padx=5, pady=5,columnspan=1, rowspan=1)
                        
        ttk.Button(tab2, text='NEXT', command = self.II).grid(row=9, column=1,sticky='WE', padx=5,\
        pady=5,columnspan=1, rowspan=1)
        
        # tlacidlo, ktorym sa ulozi obsah v okne do konkretneho suboru
        ttk.Button(tab2, text='SAVE AS',command=self.edit_save).grid(row=8, column=1,sticky='WE', padx=5,\
        pady=5,columnspan=1, rowspan=1)
        
        ttk.Button(tab2, text="QUIT", command=self.gEND).grid(row=9, column=0,sticky='WE',\
        padx=5, columnspan=1, rowspan=10,pady=5) 
        
        # tlacidlo, ktorym sa nacita obsah konkretneho txt suboru do okna PLGP
        ttk.Button(tab2, text='LOAD TXT', command = self.open_file).grid(row=7,\
        column=1, sticky='WE', padx=5, pady=5,columnspan=1, rowspan=1)

        # ~~~~~~~~~~~~~~~~~~~~~~~~ TRETIA ZALOZKA ~~~~~~~~~~~~~~~~~~~~~~~
        # zobrazenie vypocitanych vah a dalsich informacii, zobrazenie rovnice Y        
        
        ttk.Label(tab3, text=u" \n\nHandy software tool for geologists", anchor="s",\
        foreground="forest green", font = "Verdana 9 italic").grid(in_=tab3,column=0, row=0,\
        columnspan=7, sticky="S",padx=70, pady=17)
        ttk.Label(tab3, text=u"\nPredict landslide with GRASS GIS and Python", anchor="n",\
        foreground="dark green", font = "Verdana 13 bold").grid(in_=tab3,column=0, row=0,\
        columnspan=7, sticky="N",padx=30, pady=1)
        
        self.six = ttk.Labelframe(tab3, text = " 6. Information about calculated weights of all factors : " )
        self.six.grid(row=1, column=0, columnspan=2, sticky='E', padx=10, pady=5)
        
        self.txf2 = ScrolledText.ScrolledText(self.six, height = 12, width = 61) 
        self.txf2.grid(row=2, column=0,columnspan=2, rowspan=3, sticky='NS', padx=5, pady=5)
        
        self.seven = ttk.Labelframe(tab3, text = " 7. The equation to calculate value Y : " )
        self.seven.grid(row=3, column=0, columnspan=2, sticky='E', padx=10, pady=5)
        
        self.txf4 = ScrolledText.ScrolledText(self.seven, height = 3.5, width = 61) 
        self.txf4.grid(row=4, column=0,columnspan=2, rowspan=3, sticky='NS', padx=5, pady=5)
        
        ttk.Button(tab3, text='INFO',command=tkMessageBox.showinfo).grid(row=7, column=0,\
        sticky="WE", padx=5, pady=5,columnspan=1, rowspan=1)
                        
        ttk.Button(tab3, text='RUN GRASS GIS',command=self.RG).grid(row=8, column=0,\
        sticky="WE", padx=5, pady=5,columnspan=1, rowspan=1)
                        
        ttk.Button(tab3, text='NEXT', command = self.III).grid(row=9, column=1,\
        sticky='WE', padx=5,pady=5,columnspan=1, rowspan=1)
        
        # zobrazenie rovnice Y
        ttk.Button(tab3, text='EQUATION',command = self.WrRovnica).grid(row=8, column=1,\
        sticky='WE', padx=5,pady=5,columnspan=1, rowspan=1)
        
        ttk.Button(tab3, text="QUIT", command=self.gEND).grid(row=9, column=0,\
        sticky='WE',padx=5, columnspan=1, rowspan=1,pady=5) 
        
        # vypocet vah
        ttk.Button(tab3, text='CALCULATE WEIGHTS', command=self.CalculateFactors).grid(row=7,\
        column=1, sticky='WE', padx=5, pady=5,columnspan=1, rowspan=1)        
        
        # ~~~~~~~~~~~~~~~~~~~~~~~~~ STVRTA ZALOZKA ~~~~~~~~~~~~~~~~~~~~~~~~~
        # zobrazenie MIN a MAX hodnoty v bunke rasta Y
        # reklasifikacia spojiteho intervalu 
        
        ttk.Label(tab4, text=u" \n\nHandy software tool for geologists", anchor="s",\
        foreground="forest green", font = "Verdana 9 italic").grid(in_=tab4,column=0, row=0,\
        columnspan=7, sticky="S",padx=70, pady=17)
        ttk.Label(tab4, text=u"\nPredict landslide with GRASS GIS and Python", anchor="n",\
        foreground="dark green", font = "Verdana 13 bold").grid(in_=tab4,column=0, row=0,\
        columnspan=7, sticky="N",padx=30, pady=1)
        
        self.eight = ttk.Labelframe(tab4, text = " 8. The result of equation: " )
        self.eight.grid(row=1, column=0, columnspan=2, sticky='E', padx=5, pady=5)
        
        self.txf5 = ScrolledText.ScrolledText(self.eight, height = 5, width = 62) 
        self.txf5.grid(row=2, column=0,columnspan=2, rowspan=3, sticky='NS', padx=5, pady=5)
        
        self.eightt = ttk.Labelframe(tab4, text = " is raster map with MIN and MAX value:" )
        self.eightt.grid(row=3, column=0, columnspan=2, sticky='E', padx=5, pady=5)
        
        self.txf6 = ScrolledText.ScrolledText(self.eightt, height = 3, width = 62) 
        self.txf6.grid(row=4, column=0,columnspan=2, rowspan=3, sticky='NS', padx=5, pady=5)

        ttk.Button(tab4, text='INFO',command=tkMessageBox.showinfo).grid(row=4,\
        column=0,sticky="WE", padx=5, pady=5,columnspan=1, rowspan=1)        
        
        ttk.Button(tab4, text='MIN MAX',command = self.open_filey).grid(row=4,\
        column=1, sticky='WE', padx=5, pady=5,columnspan=1, rowspan=1)
        
        self.nine = ttk.Labelframe(tab4, text = " 9. Reclassification rules for result map: " )
        self.nine.grid(row=5, column=0, columnspan=2, sticky='E', padx=5, pady=5)
        
        self.txf7 = ScrolledText.ScrolledText(self.nine, height = 5.3, width = 62) 
        self.txf7.grid(row=6, column=0,columnspan=2, rowspan=3, sticky='NS', padx=5, pady=5)
        
        ttk.Button(tab4, text='SAVE AS',command=self.edit_savey).grid(row=6, column=1,\
        sticky="WE", padx=5, pady=5,columnspan=1, rowspan=1)
                        
        ttk.Button(tab4, text='NEXT', command = self.IV).grid(row=7,\
        column=1,sticky='WE',padx=5, columnspan=1, rowspan=1,pady=5)
        
        ttk.Button(tab4,text='RUN GRASS GIS',command=self.RG ).grid(row=6, column=0,sticky='WE',\
        padx=5, pady = 5, columnspan=1, rowspan=1) 
        
        ttk.Button(tab4, text="QUIT", command=self.gEND).grid(row=7, column=0,sticky='WE',\
        padx=5, columnspan=1, rowspan=10,pady=5) 
        
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~ PIATA ZALOZKA ~~~~~~~~~~~~~~~~~~~~~~~~
        # verifikacia vysledkov
        # COV1, COV2 a COV3 sa tykaju cutoffvalues, co je hranica, ktora rozdeli 
        # interval Y na dve kategorie: stabilne a nestabilne oblasti
        # v diplomovej praci je len jedna hranica (COV1,2,3 su rovnake), 
        # preto je ROC hranata: plot.png 
        
        ttk.Label(tab5, text=u" \n\nHandy software tool for geologists", anchor="s",\
        foreground="forest green", font = "Verdana 9 italic").grid(in_=tab5,column=0, row=0,\
        columnspan=7, sticky="S",padx=70, pady=17)
        ttk.Label(tab5, text=u"\nPredict landslide with GRASS GIS and Python", anchor="n",\
        foreground="dark green", font = "Verdana 13 bold").grid(in_=tab5,column=0, row=0,\
        columnspan=7, sticky="N",padx=30, pady=1)
        
        self.ten = ttk.Labelframe(tab5, text = " 10. Validation")
        self.ten.grid(row=1, column=0, columnspan=2, sticky='E', padx=10, pady=5)
        
        # zobrazenie intervalov, reklasifikacne pravidla pre rozdelenie vysledku 
        # na kategorie: stabilne a nestabilne oblasti
        self.tenL = ttk.Label(self.ten,text=" Intervals according to set cutoff value:",foreground="cadet blue")
        self.tenL.grid(row=2, column = 0, columnspan=2, sticky='W', padx=1, pady=1)
        
        self.txf8 = ScrolledText.ScrolledText(self.ten, height = 8, width = 30) 
        self.txf8.grid(row=3, column=0,columnspan=2, rowspan=1, sticky='NS', padx=5, pady=5)
        
        self.tenL = ttk.Label(self.ten,text=" Receiver operating characteristic :",foreground="cadet blue")
        self.tenL.grid(row=2, column = 2, columnspan=2, sticky='W', padx=1, pady=5)
        
        self.txf9 = ScrolledText.ScrolledText(self.ten, height = 17, width = 27) 
        self.txf9.grid(row=3, column=2,columnspan=2, rowspan=3, sticky='NS', padx=5, pady=5)
        
        # zobrazenie plochkategorii: stabilne a nestabilne oblasti
        self.tenL = ttk.Label(self.ten,text=" Area according to set cutoff value:",foreground="cadet blue")
        self.tenL.grid(row=4, column = 0, columnspan=2, sticky='W', padx=1, pady=5)
        
        self.txf10 = ScrolledText.ScrolledText(self.ten, height = 6, width = 30) 
        self.txf10.grid(row=5, column=0,columnspan=2, rowspan=1, sticky='NS', padx=5, pady=5)
        
        # zobrazenie hodnot pre vypocet plochy pod ROC krivkou
        ttk.Button(tab5, text="SHOW VALUES ", command = self.valid).grid(row=7,\
        column=0,sticky="WE", padx=5, pady=5,columnspan=1, rowspan=1)
                        
        ttk.Button(tab5, text='RUN GRASS GIS',command=self.RG).grid(row=8,\
        column=0,sticky="WE",padx=5, pady=5,columnspan=1, rowspan=1)
        
        # zobrazenie orientacneho vysledku: bez legendy, existujucich zosuvov, ...                
        ttk.Button(tab5, text="SHOW MAP",command = self.showimg).grid(row=8, column=1,sticky='WE',\
        padx=5, pady=5,columnspan=1, rowspan=1)
        
        # zobrazenie ROC krivky
        ttk.Button(tab5, text="SHOW ROC", command = self.showROC).grid(row=7, column=1,sticky='WE',\
        padx=5,pady=5,columnspan=1, rowspan=1)
        
        ttk.Button(tab5, text="QUIT", command=self.gEND).grid(row=9,\
        column=0,sticky='WE',\
        padx=5, columnspan=2, rowspan=1,pady=5) 

    # funkcia na zobrazenie prikladu ako maju vyzerat reklasifikacne pravidla
    # pre pouzitie modulu r.recode na reklasifikaciu FLOAT map
    def showexample(self):
        tkMessageBox.showinfo("recl_file",   "\nText file for reclassification:\n\n\
 MIN  :   ?   :   ?\n      ?   :   ?   :   ?\n      ?   :   ?   :   ?\n             . . .     \n                       \n      ?   :   ?   :   ?\n      ?   :  MAX  :   ? ")
    
    # funkcie na zobrazenie okna o pokracovani dalsou zalozkou
    def II(self):        
        tkMessageBox.showinfo("GO NEXT","   Continue with third tab ... ")        
    def III(self):        
        tkMessageBox.showinfo("GO NEXT","   Continue with fourth tab ... ")        
    def IV(self):        
        tkMessageBox.showinfo("GO NEXT","   Continue with fifth tab ... ")
        
    # funkcia na spustenie GRASS GIS
    def RG(self):
        try:
            os.startfile(r'C:\Program Files (x86)\GRASS GIS 7.0.0\grass70.bat')
        except:
            tkMessageBox.showwarning("","   Cannot run GRASS GIS.   ") 
    
    # funkcia na zistenie PATH k hlavnemu priecnku
    def openL(self):
        self.E12.delete(0,"end")
        #DEFAULT CESTA
        pr = askdirectory(initialdir="C:\\DP_LF")
        self.cestaL = os.path.abspath(pr)
        self.E12.insert(0, self.cestaL)
        self.cestaL = self.cestaL.encode("ascii","ignore")
        return self.cestaL
    
    # funkcia na ziskanie PATH, kde su ulozene vstupne data
    def openV(self):
        self.E21.delete(0,"end")
        #DEFAULT CESTA
        priecinok = askdirectory(initialdir="C:\\DP_LF\\data")
        self.cestaV = os.path.abspath(priecinok)
        self.E21.insert(0, self.cestaV)
        self.cestaV = self.cestaV.encode("ascii","ignore")
        return self.cestaV
        
    # funkcia na ziskanie PATH, kde budu ulozene INFO o vypocte
    def openI(self):          
        self.E31.delete(0,"end")
        #DEFAULT CESTA
        priecinok = askdirectory(initialdir="C:\\DP_LF\\vypocet")
        self.cestaI = os.path.abspath(priecinok)
        self.E31.insert(0, self.cestaI)
        self.cestaI = self.cestaI.encode("ascii","ignore")
        return self.cestaI
        
    # funkcia na vykonanie akcii po stlaceni POKRACOVAT v prvej zalozke
    # precitanie vyplnenych policok v prvej zalozke
    def valueGET(self,a,b,c,d,e):
        self.createL()        
        self.nameL = str(a)
        self.epsg = str(b)
        self.nameMV = str(c)
        self.nameMM = str(d)
        self.nameM = str(e)
        try:
            self.epsg=int(self.epsg)
        except:
            tkMessageBox.showerror( "","   EPSG code must be numeric !   " )
            self.gui.destroy()
        self.epsg=str(self.epsg)
        if ((self.nameL != "") and (self.epsg != "") and (self.nameMV != "")\
            and (self.nameMM != "") and (self.nameM != "") and (self.cestaL != "")\
            and (self.cestaV != "") and (self.cestaI != "")):              
            if tkMessageBox.askquestion("Settings", "   New LOCATION, new MAPSETs and other\n\
   necessary folders and *.txt files will be created.\n\
   All existing files with the same name will be \n\
   deleted.\n\n   Do you really want to continue?")=="yes":
       
                    # vytvorenie novych foldrov
                    nf_info = self.cestaI+"\\info" 
                    if not os.path.isdir(nf_info):
                        os.makedirs(nf_info)
                    nf_recl1 = self.cestaI+"\\recl1" #robim new folder
                    if not os.path.isdir(nf_recl1):
                        os.makedirs(nf_recl1)
                    nf_report = self.cestaI+"\\report" #robim new folder
                    if not os.path.isdir(nf_report):
                        os.makedirs(nf_report)
                    nf_recl2 = self.cestaI+"\\recl2" #robim new folder
                    if not os.path.isdir(nf_recl2):
                        os.makedirs(nf_recl2)
                        
                    # vytvorenie txt suborov na prvotnu reklasifikaciu
                    r1_G = nf_recl1+"\\recl1_G.txt" 
                    open(r1_G, 'w')
                    r1_DMR = nf_recl1+"\\recl1_DMR.txt" 
                    open(r1_DMR, 'w')
                    r1_S = nf_recl1+"\\recl1_S.txt" 
                    open(r1_S, 'w')
                    r1_E = nf_recl1+"\\recl1_E.txt" 
                    open(r1_E, 'w')
                    r1_DS = nf_recl1+"\\recl1_DS.txt" 
                    open(r1_DS, 'w')
                    r1_M = nf_recl1+"\\recl1_M.txt" 
                    open(r1_M, 'w')
                    r1_K = nf_recl1+"\\recl1_K.txt" 
                    open(r1_K, 'w')
                    r1_VK = nf_recl1+"\\recl1_VK.txt" 
                    open(r1_VK, 'w')
                    
                    # vytvorenie dalsich potrebnych txt suborov
                    open(self.cesta + "recl_y.txt","wb")
                    open(self.cesta + "recl_COV1.txt","wb")
                    open(self.cesta + "recl_COV2.txt","wb")
                    open(self.cesta + "recl_COV3.txt","wb")
                    
                    tkMessageBox.showinfo("New folders", "   In   %s   these folders have already been created:\
                    \n   1. info - information about parametric maps\
                              \n   2. recl1 - necessary rules for first reclassification\
                              \n   3. report - information about classes: areas\
                              \n   4. recl2 - necessary rules for second reclassification\n"\
                              %self.cestaI)
                    tkMessageBox.showinfo("First reclassification", "   In %s these *.txt files have already been created:\n\
                    \n   1. recl1_G.txt - geology factor\
                              \n   2. recl1_DMR.txt - DEM factor\
                              \n   3. recl1_S.txt - slope factor\
                              \n   4. recl1_E.txt - aspect factor\
                              \n   5. recl1_DS.txt - flowlength factor\
                              \n   6. recl1_M.txt - accumulation factor\
                              \n   7. recl1_K.txt - curvature factor\
                              \n   8. recl1_VK.txt - landuse factor\n" %nf_recl1)          
                    tkMessageBox.showinfo("GO NEXT","   Continue with second tab ... ")
            else:
                    self.gui.destroy()    
        else:
            tkMessageBox.showerror("", "   ERROR \n\n   Check the input values !" )
        return self.cestaL  
    
    # funkcia na vymazanie obsahu defaultne vyplnenych policok
    def refreshALL(self):
        self.E10.delete(0,"end")
        self.E11.delete(0,"end")
        self.E12.delete(0,"end")
        self.E13.delete(0,"end")
        self.E14.delete(0,"end")
        self.E15.delete(0,"end")
        self.E21.delete(0,"end")
        self.E31.delete(0,"end")
    
    # funkcia na ukoncenie prace v PLGP
    def gEND(self):
        if tkMessageBox.askyesno('Verification', '   Do you really want to quit?   '):
            self.gui.destroy()
        else:
            tkMessageBox.askretrycancel("No", '   Press ENTER to continue   ') 
           
    def wrZM(self):
        # vymazanie obsahu a vypisanie mapsetov, rastrov a vektorov do okna txf1
        self.txf1.delete(1.0, END) 
        redir = Presmerovanie(self.txf1)
        sys.stdout = redir
        self.zm() 
        self.zistiR()
        self.zistiV()        
        # self.txf1.insert(INSERT,"Existujuce rastrove mapy:\n\nExistujuce vektorove mapy:")
        # print(self.txf1.get(1.0, END))
                    
    def delZM(self):
        self.txf1.delete(1.0, END)
        
    def open_file(self):
        #zabezpeci ze sa obsah txt zobrazi do okna 
        self.txf3.delete(1.0, END)
        redir = Presmerovanie(self.txf3)
        sys.stdout = redir
 
        self.txf3.delete(1.0, END)        
        options = {}
        options['defaultextension'] = '.txt'
        options['filetypes'] = [('all files', '.*'), ('text files', '.txt')]
        options['initialdir'] = "C:\\DP_LF\\vypocet\\info"
        options['parent'] = self.gui
        options['title'] = "Open a file"
        
        # z txt suboru INFO precita iba informacie o MIN a MAX hodnote bunky
        with tkFileDialog.askopenfile(mode='r', initialdir = "C:\\DP_LF\\vypocet\\info") as f_handle:
            pr = os.path.curdir
            self.oo = os.path.abspath(pr)
            self.oo = self.oo.encode("ascii","ignore")
            #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  vytlacit nazov suboru              
            print "Map:"
            print "---------------------------------------"
            print "MIN and MAX cell value in raster of selected factor :\n"
            #vytlaci obsah suboru
            for line in f_handle:
                line = line.strip()
                if line == "": continue 
                if "max" in line:
                    print line
                if "min" in line:
                    print line
                    
    # ulozit subor txt ako ...                
    def edit_savey(self):
        options = {}
        options['defaultextension'] = '.txt'
        options['filetypes'] = [('all files', '.*'), ('text files', '.txt')]
        options['parent'] = self.gui
        options['title'] = "Save as ..."
        f = asksaveasfile(mode='w+', defaultextension=".txt", initialdir = "C:\\DP_LF\\vypocet")
        if not f:
            return
        f.write(self.txf7.get(1.0, END))
        f.close()
    
    # otvorenie txt suboru INFO    
    def open_filey(self):
        # zabezpeci ze sa obsah txt zobrazi do okna 
        self.txf6.delete(1.0, END)
        redir = Presmerovanie(self.txf6)
        sys.stdout = redir
      
        options = {}
        options['defaultextension'] = '.txt'
        options['filetypes'] = [('all files', '.*'), ('text files', '.txt')]
        options['initialdir'] = "C:\\DP_LF\\vypocet"
        options['parent'] = self.gui
        options['title'] = "Open a file"
        
        f_handle = "C:\\DP_LF\\vypocet\\info_y.txt"
        file = open(f_handle, 'r')
        # vytlaci obsah suboru
        for line in file:
            line = line.strip()
            if line == "": continue 
            if "max" in line:
                print line
            if "min" in line:
                print line
                 
    def edit_save(self):
        options = {}
        options['defaultextension'] = '.txt'
        options['filetypes'] = [('all files', '.*'), ('text files', '.txt')]
        options['parent'] = self.gui
        options['title'] = "Save as ..."
        f = asksaveasfile(mode='w+', defaultextension=".txt", initialdir = "C:\\DP_LF\\vypocet\\recl1")
        if not f:
            return
        f.write(self.txf3.get(1.0, END))
        f.close()
    
    # vytvorenie LOCATION                
    def createL(self):
        import grass.script as gscript
        import grass.script.setup as gsetup
        import grass.script.core as gcore
        cestaL = self.Gobj.gisdb 
        nameL = self.nameL
        epsg = self.epsg       
        mapset = self.nameMV
        mapset1 = self.nameMM
        mapset2 = self.nameM         
        gisbase = self.Gobj.gisbase
        gsetup.init(gisbase, cestaL, nameL, "PERMANENT")
        #vytvorenie LOCATION
        gcore.create_location(cestaL, nameL, epsg=epsg, proj4=None, filename=None, wkt=None,\
        datum=None, datum_trans=None, desc=None, overwrite=True)
        
        # vytvorenie MAPSETov
        gscript.run_command("g.mapset",overwrite = True,mapset = mapset, flags="c")
        gscript.run_command("g.mapset",overwrite = True,mapset = mapset1, flags="c")
        gscript.run_command("g.mapset",overwrite = True,mapset = mapset2, flags="c")
    
    # vypise zoznam mapsetov v location   
    def zm(self):
        import grass.script as gscript
        print "MAPSETs:"
        print gscript.read_command("g.mapsets",flags = "l")
    
    # vypise zoznam rastrov
    def zistiR(self):    
        import grass.script as gscript
        print "Raster maps:"
        for rast in gscript.list_strings(type = 'rast'):
            print rast,
    
    # vypise zoznam vektorov       
    def zistiV(self):
        import grass.script as gscript
        print "\nVector maps:"
        for vect in gscript.list_strings(type = 'vect'):
            print vect,    
    
    # vypocet vahy konkretneho faktora
    def Faktor(self, faktor):
        import math
        import scipy
        
        # funkcia na ulozenie reklasifikacnych pravidiel pre II reklasifikaciu
        def STL(a,b,c):
            ctxt = self.cesta + "recl2\\" + "recl2_" + str(c) + ".txt"
            file = open(ctxt, 'w+')
            for j,k in zip(a, b):
                file.writelines("%r = %r\n" % (j,k))
            file.close()
        
        # funkcia na citanie obsahu z reportov
        def Report(self,F):
            import csv       
            
            tf = open(F, "rb")
            lines = tf.readlines()  
            lines1 = lines[4:(len(lines)-3)]
            data = csv.reader(lines1, delimiter="|")
            table = [row for row in data]
            self.recl1 = [None]
            self.P = [None]
            for row in table:
                a = row[1]
                b = row[3]
                if self.recl1 is [None]:
                    self.recl1 = [a]
                else: self.recl1.append(a)
                if self.P is [None]:
                    self.P = [b]
                else: self.P.append(b)
            del self.recl1[0]
            del self.P[0]
            self.recl1 = [int(i) for i in self.recl1]
            self.P = [float(i) for i in self.P]
            STL(self.recl1, self.P, faktor)
            return (self.recl1,self.P)
        
        f1 = "report_"
        f2 = str(faktor)
        f3 = ".txt"
        f4 = "_z.txt"
        Ft = self.cesta+"report\\"+f1+f2+f3
        Ftz = self.cesta+"report\\"+f1+f2+f4
        
        # plocha triedy
        pt = Report(self, Ft)        
        Pt = pt[1]
        recl1t = pt[0]
        # plocha zosuvov v triede        
        ptz = Report(self, Ftz)
        Ptz = ptz[1]
        recl1tz = ptz[0]
        # pocet tried parametrickej mapy
        s = len(Pt)
        # pravdepodobnost vzniku svahovych deformacii v triede       
        p = [(Ptzi)/Pti for Ptzi,Pti in zip(Ptz,Pt)]
        # sucet pravdepodobnosti v ramci parametra        
        p_sum = sum(p)
        # hustota pravdepodobnosti
        pp = [(pi)/p_sum for pi in p]
        # hodnota entropie
        H = (-1)*(sum([(math.log(pi)/math.log(2))*pi for pi in pp]))
        # maximalna entropia
        Hmax = math.log(s)/math.log(2)
        # priemerna hodnota pravdepodobnosti
        p_pr = scipy.mean(p)
        # informacny koeficient
        I = (Hmax - H)/Hmax
        # vaha prislusneho parametra
        W = I*p_pr
        
        recl1_u,pp_u = zip(*sorted(zip(self.recl1,pp), key=lambda x: x[1]))
        recl1_u = list(recl1_u) 
        
        print "Factor", faktor,":"
        print "---------------------------------------"
        print "Weight of factor",faktor, "is %s." % W
        print "Second reclassification is saved in *.txt file in\n%s." % (self.cesta + "recl2\\" + faktor + "_recl2.txt")
        STL(recl1_u, self.recl1, faktor)
        # print Pt[0], Psd[0], p[0], pp[0], H, s, Hmax, p_pr, I, W
        if len(recl1t) == len(recl1tz):
            print "Landslides occure in all classes.\n"
        else:
            print "Landslides occure not in all classes.\n"
        return float(W)
        
    def CalculateFactors(self):
        # zabezpeci ze sa obsah txt zobrazi do okna  
        self.txf2.delete(1.0, END)
        redir = Presmerovanie(self.txf2)
        sys.stdout = redir
        self.Wg = self.Faktor("G")  
        self.Wdmr = self.Faktor("DMR")
        self.Ws = self.Faktor("S")
        self.We = self.Faktor("E")
        self.Wds = self.Faktor("DS")
        self.Wk = self.Faktor("K")
        self.Wm = self.Faktor("M")
        self.Wvk = self.Faktor("VK")
    
    # vypisanie rovnice do okna
    def WrRovnica(self): 
        self.txf4.delete(1.0, END)
        redir = Presmerovanie(self.txf4)
        sys.stdout = redir
        print "y = geology_recl2 * %f + dmr_recl2 * %f + slope_recl2 * %f + aspect_recl2 * %f + curv_m_recl2 * %f + flowlength_recl2 * %f + accumulation_recl2 * %f + landuse_recl2 * %f" % (self.Wg, self.Wdmr, self.Ws, self.We, self.Wk, self.Wds,self.Wm, self.Wvk)
        self.ypsilon()        
    
    # vypisanie rovnice do txt suboru    
    def ypsilon(self):      
        ctxt = self.cesta + "rovnica.txt"
        file = open(ctxt, 'w+')
        file.write(self.txf4.get(1.0, END))        
        file.close()
        self.txf5.delete(1.0, END)
        redir = Presmerovanie(self.txf5)
        sys.stdout = redir
        print self.txf4.get(1.0, END)
            
    def valid(self):
        self.valrecl()
        self.bastats()
        self.val()

    def val(self):
        import numpy as np
        import pylab as pl
        self.txf9.delete(1.0, END)
        redir = Presmerovanie(self.txf9)
        sys.stdout = redir
        ctxt4 = self.cesta + "stats_COV1.txt"
        try:
            fhand = open(ctxt4)
        except:
            print "File not found:",ctxt4
        lst = list()    
        for line in fhand:
            line.rstrip()
            if line == "": continue
            a = line.split()
            for word in a: 
                lst.append(word)
        lst=[ lst[i] for i in range(len(lst))]
        tn4 = float(lst[2])
        fn4 = float(lst[5])
        fp4 = float(lst[8])
        tp4 = float(lst[11])
        N4 = tn4+fp4
        P4 = fn4+tp4
        TP4 = 1-tp4/P4
        FP4 = fp4/N4
        
        ctxt6 = self.cesta + "stats_COV2.txt"
        try:
            fhand = open(ctxt6)
        except:
            print "File not found:",ctxt6
        lst = list()    
        for line in fhand:
            line.rstrip()
            if line == "": continue
            a = line.split()
            for word in a: 
                lst.append(word)
        lst=[ lst[i] for i in range(len(lst))]
        tn6 = float(lst[2])
        fn6 = float(lst[5])
        fp6 = float(lst[8])
        tp6 = float(lst[11])
        N6 = tn6+fp6
        P6 = fn6+tp6
        TP6 = 1-tp6/P6
        FP6 = fp6/N6
        
        ctxt8 = self.cesta + "stats_COV3.txt"
        try:
            fhand = open(ctxt8)
        except:
            print "File not found:",ctxt8
        lst = list()    
        for line in fhand:
            line.rstrip()
            if line == "": continue
            a = line.split()
            for word in a: 
                lst.append(word)
        lst=[ lst[i] for i in range(len(lst))]
        tn8 = float(lst[2])
        fn8 = float(lst[5])
        fp8 = float(lst[8])
        tp8 = float(lst[11])
        N8 = tn8+fp8
        P8 = fn8+tp8
        TP8 = 1-tp8/P8
        FP8 = fp8/N8
        
        x = 0,FP4,FP6,FP8,1
        y = 0,TP4,TP6,TP8,1
    
        # AUC
        self.auc = np.trapz(y,x)
        
        # ROC curve
        pl.clf()
        pl.plot(x, y, "r", linewidth="1.7", label='ROC curve (area = %0.2f)' % self.auc)
        pl.plot([0, 1], [0, 1], 'r--',alpha=0.57)
        pl.xlim([0.0, 1.0])
        pl.ylim([0.0, 1.0])
        pl.xlabel('False Positive Rate')
        pl.ylabel('True Positive Rate')
        pl.title('Receiver operating characteristic')
        pl.legend(loc="lower right")
        pl.fill_between(x,y,color="red",alpha=0.17)
        pl.grid(True,alpha=0.7)
        pl.savefig(self.cesta + "plot.png")
    
        areaUC = self.auc*100.00
        print "Area under the ROC curve:\n%0.2f" % areaUC,"%"        
        print "\n(I. COV)\n-------------\n*true negative: %0.2f" % (((tn4)/(N4+P4))*100),"%"
        print "*false negative: %0.2f" % (((fn4)/(N4+P4))*100),"%"
        print "*false positive: %0.2f" % (((fp4)/(N4+P4))*100),"%"
        print "*true positive: %0.2f" % (((tp4)/(N4+P4))*100),"%"
        print "*FP = %0.2f" % FP4
        print "*TP = %0.2f" % TP4
        print "\n(II. COV)\n-------------\n*true negative: %0.2f" % (((tn6)/(N6+P6))*100),"%"
        print "*false negative: %0.2f" % (((fn6)/(N6+P6))*100),"%"
        print "*false positive: %0.2f" % (((fp6)/(N6+P6))*100),"%"
        print "*true positive: %0.2f" % (((tp6)/(N6+P6))*100),"%"
        print "*FP = %0.2f" % FP6
        print "*TP = %0.2f" % TP6
        print "\n(III. COV)\n-------------\n*true negative: %0.2f" % (((tn8)/(N8+P8))*100),"%"
        print "*false negative: %0.2f" % (((fn8)/(N8+P8))*100),"%"
        print "*false positive: %0.2f" % (((fp8)/(N8+P8))*100),"%"
        print "*true positive: %0.2f" % (((tp8)/(N8+P8))*100),"%"
        print "*FP = %0.2f" % FP8
        print "*TP = %0.2f" % TP8
        
    def bastats(self):      
        self.txf10.delete(1.0, END)
        redir = Presmerovanie(self.txf10)
        sys.stdout = redir
        print "(I. COV):\n-------------"
        self.BA_stats(1)
        print "(II. COV):\n-------------"
        self.BA_stats(2)
        print "(III. COV):\n-------------"
        self.BA_stats(3)
          
    def BA_stats(self,fstats):
        ctxt = self.cesta + "y_stats_COV" + str(fstats) + ".txt"
        try:
            fhand = open(ctxt)
        except:
            print "File not found:",ctxt
        lst = list()    
        for line in fhand:
            line.rstrip()
            if line == "": continue
            a = line.split()
            for word in a: 
                lst.append(word)
        lst=[ lst[i] for i in range(len(lst))]
        a = lst[1]
        b = lst[3]
        c = float(a)+ float(b)
         
        pa = (float(a)/c)*100
        pb = (float(b)/c)*100
        print "*without landslide: %0.2f" % (pa),"%"
        print "*with landslide: %0.2f" % (pb),"%\n"
    
    def valrecl(self):
        self.txf8.delete(1.0, END)
        redir = Presmerovanie(self.txf8)       
        sys.stdout = redir
        print "(I. COV):\n-------------"
        self.VAL_recl(1)
        print "(II. COV):\n-------------"
        self.VAL_recl(2)
        print "(III. COV):\n-------------"
        self.VAL_recl(3)
        
    def VAL_recl(self,frecl):          
        ctxt = self.cesta + "recl_COV" + str(frecl) + ".txt"
        try:
            fhand = open(ctxt)
        except:
            print "File not found:",ctxt
        lst = list()    
        for line in fhand:
            line.rstrip()
            if line == "": continue
            a = line.split(":")
            for word in a: 
                lst.append(word)
        lst=[ lst[i] for i in range(len(lst))]
        # print lst
        a = lst[0]
        b = lst[1]
        c = lst[3]
        d = lst[4]
        print "*without landslide" 
        print a,"-",b
        print "*with landslide"
        print c,"-",d,"\n"        

    # zobrazenie orientacnej mapy po stlaceni prislusneho tlacidla
    def showimg(self):
        image = self.cesta + "y.png"
        try:
            os.startfile(image)
        except:
            tkMessageBox.showwarning("","   Cannot open map.   ")
    # zobrazenie ROC krivky po stlaceni prislusneho tlacidla    
    def showROC(self):
        ROCg = self.cesta + "plot.png"
        try:
            os.startfile(ROCg)
        except:
            tkMessageBox.showwarning("","   Cannot open map.   ")
        
# ~~~~~~ HLAVNE GUI ~~~~~~~~
def main(): 
    
    gui = Tkinter.Tk()
    # zobrazenie grafickej casti okna GUI
    o1 = PhotoImage(file="files\gui.gif")
    def panelObr(o):   
        Label(gui, image=o).pack(side="right", fill="both", expand=True)

    panelObr(o1)
    GUI(gui).pack(side="right", fill="both", expand=True)
    gui.mainloop()   
    
if __name__ == '__main__':
    main()
    
    
    
## PRVY MODEL: import dat, tvorba parametrickych map, export informacii o kazdej z nich)
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#import sys
#import os
#import atexit
#
#from grass.script import parser, run_command
#
#def cleanup():
#    pass
#
#def main():
#    run_command("v.in.ogr",
#                flags = 'o',
#                overwrite = True,
#                input = "C:\DP_LF\data",
#                layer = "area",
#                output = "area",
#                min_area = 0.0001,
#                snap = -1,
#                geometry = "None")
#
#    run_command("v.in.ogr",
#                flags = 'o',
#                overwrite = True,
#                input = "C:\DP_LF\data",
#                layer = "geology",
#                output = "geology",
#                min_area = 0.0001,
#                snap = -1,
#                geometry = "None")
#
#    run_command("v.in.ogr",
#                flags = 'o',
#                overwrite = True,
#                input = "C:\DP_LF\data",
#                layer = "polohopis",
#                output = "polohopis",
#                min_area = 0.0001,
#                snap = -1,
#                geometry = "None")
#
#    run_command("v.in.ogr",
#                flags = 'o',
#                overwrite = True,
#                input = "C:\DP_LF\data",
#                layer = "vyskopis",
#                output = "vyskopis",
#                min_area = 0.0001,
#                snap = -1,
#                geometry = "None")
#
#    run_command("v.in.ogr",
#                flags = 'o',
#                overwrite = True,
#                input = "C:\DP_LF\data",
#                layer = "zosuvy",
#                output = "zosuvy",
#                min_area = 0.0001,
#                snap = -1,
#                geometry = "None")
#
#    run_command("g.region",
#                overwrite = True,
#                vector = "area",
#                res = "10")
#
#    run_command("v.to.rast",
#                overwrite = True,
#                input = "area",
#                layer = "1",
#                type = "point,line,area",
#                output = "zu",
#                use = "attr",
#                attribute_column = "Id",
#                value = 1,
#                memory = 300)
#
#    run_command("v.to.rast",
#                overwrite = True,
#                input = "geology",
#                layer = "1",
#                type = "point,line,area",
#                output = "geology",
#                use = "attr",
#                attribute_column = "kat",
#                value = 1,
#                memory = 300)
#
#    run_command("v.to.rast",
#                overwrite = True,
#                input = "polohopis",
#                layer = "1",
#                type = "point,line,area",
#                output = "landuse",
#                use = "attr",
#                attribute_column = "Id",
#                value = 1,
#                memory = 300)
#
#    run_command("v.to.rast",
#                overwrite = True,
#                input = "zosuvy",
#                layer = "1",
#                type = "point,line,area",
#                output = "zosuvy0",
#                use = "attr",
#                attribute_column = "Id",
#                value = 1,
#                memory = 300)
#
#    run_command("r.mapcalc",
#                overwrite = True,
#                expression = "zosuvy = if( zosuvy0 == 0, null(), 1)")
#
#    run_command("r.mask",
#                overwrite = True,
#                raster = "zu",
#                maskcats = "*",
#                layer = "1")
#
#    run_command("v.surf.rst",
#                overwrite = True,
#                input = "vyskopis",
#                layer = "1",
#                zcolumn = "VYSKA",
#                elevation = "dmr",
#                slope = "slope",
#                aspect = "aspect",
#                pcurvature = "curvature_p_rst",
#                tcurvature = "curvature_t_rst",
#                mcurvature = "curvature_m",
#                tension = 40.,
#                segmax = 40,
#                npmin = 300,
#                zscale = 1.0)
#
#    run_command("r.flow",
#                overwrite = True,
#                elevation = "dmr",
#                flowlength = "flowlength")
#
#    run_command("r.terraflow",
#                overwrite = True,
#                elevation = "dmr",
#                filled = "filled",
#                direction = "direction",
#                swatershed = "swatershed",
#                accumulation = "accumulation",
#                tci = "tci",
#                memory = 300)
#
#    run_command("r.univar",
#                flags = 'g',
#                overwrite = True,
#                map = "geology",
#                output = "C:\DP_LF\vypocet\info\info_G.txt",
#                percentile = 90,
#                separator = "pipe")
#
#    run_command("r.univar",
#                flags = 'g',
#                overwrite = True,
#                map = "dmr",
#                output = "C:\DP_LF\vypocet\info\info_DMR.txt",
#                percentile = 90,
#                separator = "pipe")
#
#    run_command("r.univar",
#                flags = 'g',
#                overwrite = True,
#                map = "curvature_m",
#                output = "C:\DP_LF\vypocet\info\info_K.txt",
#                percentile = 90,
#                separator = "pipe")
#
#    run_command("r.univar",
#                flags = 'g',
#                overwrite = True,
#                map = "flowlength",
#                output = "C:\DP_LF\vypocet\info\info_DS.txt",
#                percentile = 90,
#                separator = "pipe")
#
#    run_command("r.univar",
#                flags = 'g',
#                overwrite = True,
#                map = "accumulation",
#                output = "C:\DP_LF\vypocet\info\info_M.txt",
#                percentile = 90,
#                separator = "pipe")
#
#    run_command("r.univar",
#                flags = 'g',
#                overwrite = True,
#                map = "landuse",
#                output = "C:\DP_LF\vypocet\info\info_VK.txt",
#                percentile = 90,
#                separator = "pipe")
#
#    run_command("r.univar",
#                flags = 'g',
#                overwrite = True,
#                map = "aspect",
#                output = "C:\DP_LF\vypocet\info\info_E.txt",
#                percentile = 90,
#                separator = "pipe")
#
#    run_command("r.univar",
#                flags = 'g',
#                overwrite = True,
#                map = "slope",
#                output = "C:\DP_LF\vypocet\info\info_S.txt",
#                percentile = 90,
#                separator = "pipe")
#
#    return 0
#
#if __name__ == "__main__":
#    options, flags = parser()
#    atexit.register(cleanup)
#    sys.exit(main())
#
## DRUHY MODEL: prvotna reklasifikacia parametrickych map, export informacii 
## o ploche kazdej triedy a ploche zosuvov v tejto triede
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#import sys
#import os
#import atexit
#
#from grass.script import parser, run_command
#
#def cleanup():
#    pass
#
#def main():
#    run_command("r.reclass",
#                overwrite = True,
#                input = "geology",
#                output = "geology_recl1",
#                rules = "C:\DP_LF\vypocet\recl1\recl1_G.txt")
#
#    run_command("r.recode",
#                overwrite = True,
#                input = "dmr",
#                output = "dmr_recl1",
#                rules = "C:\DP_LF\vypocet\recl1\recl1_DMR.txt")
#
#    run_command("r.recode",
#                overwrite = True,
#                input = "slope",
#                output = "slope_recl1",
#                rules = "C:\DP_LF\vypocet\recl1\recl1_S.txt")
#
#    run_command("r.recode",
#                overwrite = True,
#                input = "aspect",
#                output = "aspect_recl1",
#                rules = "C:\DP_LF\vypocet\recl1\recl1_E.txt")
#
#    run_command("r.reclass",
#                overwrite = True,
#                input = "landuse",
#                output = "landuse_recl1",
#                rules = "C:\DP_LF\vypocet\recl1\recl1_VK.txt")
#
#    run_command("r.recode",
#                overwrite = True,
#                input = "flowlength",
#                output = "flowlength_recl1",
#                rules = "C:\DP_LF\vypocet\recl1\recl1_DS.txt")
#
#    run_command("r.recode",
#                overwrite = True,
#                input = "accumulation",
#                output = "accumulation_recl1",
#                rules = "C:\DP_LF\vypocet\recl1\recl1_M.txt")
#
#    run_command("r.recode",
#                overwrite = True,
#                input = "curvature_m",
#                output = "curv_m_recl1",
#                rules = "C:\DP_LF\vypocet\recl1\recl1_K.txt")
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "geology_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_G.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "dmr_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_DMR.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "slope_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_S.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "aspect_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_E.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "landuse_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_VK.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "flowlength_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_DS.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "accumulation_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_M.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "curv_m_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_K.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.mask",
#                overwrite = True,
#                raster = "zosuvy",
#                maskcats = "*",
#                layer = "1")
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "geology_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_G_z.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "dmr_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_DMR_z.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "slope_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_S_z.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "aspect_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_E_z.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "landuse_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_VK_z.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "flowlength_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_DS_z.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "accumulation_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_M_z.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.report",
#                flags = 'hn',
#                overwrite = True,
#                map = "curv_m_recl1",
#                units = "k,p",
#                output = "C:\DP_LF\vypocet\report\report_K_z.txt",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.mask",
#                overwrite = True,
#                raster = "zu",
#                maskcats = "*",
#                layer = "1")
#
#    return 0
#
#if __name__ == "__main__":
#    options, flags = parser()
#    atexit.register(cleanup)
#    sys.exit(main())
#
## TRETI MODEL: druhotna reklasifikacia parametrickych map
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#import sys
#import os
#import atexit
#
#from grass.script import parser, run_command
#
#def cleanup():
#    pass
#
#def main():
#    run_command("r.reclass",
#                overwrite = True,
#                input = "geology",
#                output = "geology_recl2",
#                rules = "C:\DP_LF\vypocet\recl2\recl2_G.txt")
#
#    run_command("r.reclass",
#                overwrite = True,
#                input = "dmr_recl1",
#                output = "dmr_recl2",
#                rules = "C:\DP_LF\vypocet\recl2\recl2_DMR.txt")
#
#    run_command("r.reclass",
#                overwrite = True,
#                input = "slope_recl1",
#                output = "slope_recl2",
#                rules = "C:\DP_LF\vypocet\recl2\recl2_S.txt")
#
#    run_command("r.reclass",
#                overwrite = True,
#                input = "aspect_recl1",
#                output = "aspect_recl2",
#                rules = "C:\DP_LF\vypocet\recl2\recl2_E.txt")
#
#    run_command("r.reclass",
#                overwrite = True,
#                input = "landuse_recl1",
#                output = "landuse_recl2",
#                rules = "C:\DP_LF\vypocet\recl2\recl2_VK.txt")
#
#    run_command("r.reclass",
#                overwrite = True,
#                input = "flowlength_recl1",
#                output = "flowlength_recl2",
#                rules = "C:\DP_LF\vypocet\recl2\recl2_DS.txt")
#
#    run_command("r.reclass",
#                overwrite = True,
#                input = "accumulation_recl1",
#                output = "accumulation_recl2",
#                rules = "C:\DP_LF\vypocet\recl2\recl2_M.txt")
#
#    run_command("r.reclass",
#                overwrite = True,
#                input = "curv_m_recl1",
#                output = "curv_m_recl2",
#                rules = "C:\DP_LF\vypocet\recl2\recl2_K.txt")
#
#    run_command("r.mapcalc",
#                overwrite = True,
#                file = "C:\DP_LF\vypocet\rovnica.txt")
#
#    run_command("r.univar",
#                flags = 'g',
#                overwrite = True,
#                map = "y",
#                output = "C:\DP_LF\vypocet\info_y.txt",
#                percentile = 90,
#                separator = "pipe")
#
#    return 0
#
#if __name__ == "__main__":
#    options, flags = parser()
#    atexit.register(cleanup)
#    sys.exit(main())
#
## STVRTY MODEL: rozdelenie spojiteho intervalu do kategorii (viac ako dva alebo dva) 
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#import sys
#import os
#import atexit
#
#from grass.script import parser, run_command
#
#def cleanup():
#    pass
#
#def main():
#    run_command("r.quantile",
#                flags = 'r',
#                input = "y",
#                quantiles = 5,
#                bins = 1000000)
#
#    run_command("r.quantile",
#                flags = 'r',
#                quiet = True,
#                input = "y",
#                quantiles = -1000000000,
#                percentiles = 90,
#                bins = 1000000)
#
#    return 0
#
#if __name__ == "__main__":
#    options, flags = parser()
#    atexit.register(cleanup)
#    sys.exit(main())
#
## PIATY MODEL: export vyslednej mapy, nastavenie farieb, reklasifikacia mapy Y 
## a export informacii o mapach pre validaciu a zostrojenie ROC krivky (tri cutoff values)
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#import sys
#import os
#import atexit
#
#from grass.script import parser, run_command
#
#def cleanup():
#    pass
#
#def main():
#    run_command("r.colors",
#                flags = 'e',
#                map = "y",
#                color = "gyr")
#
#    run_command("r.recode",
#                overwrite = True,
#                input = "y",
#                output = "ba",
#                rules = "C:\DP_LF\vypocet\recl_y.txt",
#                title = "kategorie")
#
#    run_command("r.out.png",
#                flags = 't',
#                overwrite = True,
#                input = "y",
#                output = "C:\DP_LF\vypocet\y.png",
#                compression = 7)
#
#    run_command("r.recode",
#                overwrite = True,
#                input = "y",
#                output = "y_COV1",
#                rules = "C:\DP_LF\vypocet\recl_COV1.txt",
#                title = "validation")
#
#    run_command("r.stats",
#                flags = 'an',
#                overwrite = True,
#                input = "y_COV1",
#                output = "C:\DP_LF\vypocet\y_stats_COV1.txt",
#                separator = "space",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.stats",
#                flags = 'cn',
#                overwrite = True,
#                input = "zosuvy0,y_COV1",
#                output = "C:\DP_LF\vypocet\stats_COV1.txt",
#                separator = "space",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.recode",
#                overwrite = True,
#                input = "y",
#                output = "y_COV2",
#                rules = "C:\DP_LF\vypocet\recl_COV2.txt")
#
#    run_command("r.stats",
#                flags = 'an',
#                overwrite = True,
#                input = "y_COV2",
#                output = "C:\DP_LF\vypocet\y_stats_COV2.txt",
#                separator = "space",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.stats",
#                flags = 'cn',
#                overwrite = True,
#                input = "zosuvy0,y_COV2",
#                output = "C:\DP_LF\vypocet\stats_COV2.txt",
#                separator = "space",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.recode",
#                overwrite = True,
#                input = "y",
#                output = "y_COV3",
#                rules = "C:\DP_LF\vypocet\recl_COV3.txt")
#
#    run_command("r.stats",
#                flags = 'an',
#                overwrite = True,
#                input = "y_COV3",
#                output = "C:\DP_LF\vypocet\y_stats_COV3.txt",
#                separator = "space",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.stats",
#                flags = 'cn',
#                overwrite = True,
#                input = "zosuvy0,y_COV3",
#                output = "C:\DP_LF\vypocet\stats_COV3.txt",
#                separator = "space",
#                null_value = "*",
#                nsteps = 255)
#
#    run_command("r.category",
#                map = "ba",
#                separator = ":",
#                rules = "C:\DP_LF\nastroj\files\display\cat_vysledok.txt")
#
#
#    return 0
#
#
#if __name__ == "__main__":
#    options, flags = parser()
#    atexit.register(cleanup)
#    sys.exit(main())