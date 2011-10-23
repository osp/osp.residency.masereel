import fontforge                                 
from glob import glob

for fontname in glob("./*.ttf"):
	
	font = fontforge.open (fontname) 
	fontforge.printSetup ("pdf-file", fontname + ".pdf")
	font.printSample ("fontdisplay",12, "", fontname + ".pdf")

