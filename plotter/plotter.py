# -*- coding: utf-8 -*-
import svgwrite
from math import ceil
from datetime import *
import re
import codecs

# Expected input
# data {
#   'creationDate': %Y-%m-%d %H:%M
#   'maxDate': %Y-%m-%d %H:%M
# ? 'roundness': [0-1]
#
# }

timefrm = '%Y-%m-%d %H:%M'
outputSize = (1500, 1500) # [width, height]
timeGrid = [datetime.strptime ('1998-01-01 00:00', timefrm), datetime.today()]
gridTimeSpan = timeGrid[1] - timeGrid[0]
pixelGrid = ((0,0), outputSize) # (x,y), (x,y)

resultfile = "plot.svg"
filepath = "output.sh"

plot = svgwrite.Drawing (filename = resultfile, size = (pixelGrid[1][0], pixelGrid[1][1]), viewBox = str (pixelGrid[0][0]) + " " + str (pixelGrid[0][1]) + " " + str (pixelGrid[1][0]) + " " + str (pixelGrid[1][1]))

data =  [
            {'creationDate' : '2001-04-04 04:04', 'maxDate' : '2007-05-05 05:05'},
            {'creationDate' : '1998-04-04 04:04', 'maxDate' : '1998-05-05 05:05'},
            {'creationDate' : '2004-04-04 04:04', 'maxDate' : '2005-05-05 05:05'}
        ]


##  |   
##  |   Functions
##  v

def drawBag (p, w, h, r, c):
    bag = plot.path (color = c)
    
    ro = r * h * 0.5 # Get roundness offset

    # Uppercase commands are absolute, lowercase relative

    # Move to beginning of bag
    bag.push ("M " + str(p[0]) + " " + str(p[1]))
    
    # Top
    bag.push ("c " + str(ro) + " " + str(-1 * ro) + " "      # First control point
              + str(w - ro) + " " + str(-1 * ro) + " "       # Second control point
              + str(w) + " 0 ")     # End of curve
    
    # Right
    bag.push ("s " + str(ro) + " " + str(h - ro) + " "  # Control point
              + "0 " + str(h))                          # End of curve  
    # Bottom
    bag.push ("s " + str(-1 * (w - ro)) + " " + str(ro) + " " # Control point
              + "-" + str(w) + " 0 ")                   # End of curve

    # Left
    bag.push ("s " + str(-1 * ro) + " " + str(-1 * (h - ro)) + " " # Control point
              + "0 -" + str(h))                         # End of curve 

    
    bag.push ("Z")

    plot.add (bag)

def getPosition (data):
    timeOffset = data[3] - timeGrid[0]
    	
    x = ceil ((float (timeOffset.days) / float (gridTimeSpan.days)) * outputSize[1])
    y = outputSize[1] / 2

    return (x, y) 

def getWidth (data):
    timeSpan = data[4] - data[3]

    return ceil ((float (timeSpan.days) / float(gridTimeSpan.days)) * outputSize[1])

def getHeight (data):
    return 20

def getRoundness (data):
    return 0.2

def getColor (data):
    return "black"

def parsefonts (data):
    result = {}    
    
    chunks = data.split ('‽')
    
    for chunk in chunks:
        elements = chunk.split ('‼')
        if len(elements) > 1 :
           filename = elements[0]
           fonts = elements[1].split ('⁇')

           result[filename] = fonts

    return result

#   |   
#   |   Actual script
#   V

data_input = open (filepath)

# Expected elements
# 0 $CURDIR 
# 1 $COUNT1
# 2 $TOTALSIZE
# 3 $START
# 4 $END
# 5 $EXTS
# 6 $PDFFONTS

data = []

# Parses the lines into readable data
for line in data_input:
    elements = line.split (';')
    elements = [element.strip(' ') for element in elements] # Strip space from all the elements

    if (len (elements) == 7):
        if (re.match ('^\d{4}-\d{2}-\d{2}$', elements[3])): 
            elements[3] = datetime.strptime ('{0} 00:00'.format(elements[3]), timefrm)
        if (re.match ('^\d{4}-\d{2}-\d{2}$', elements[4])): 
            elements[4] = datetime.strptime ('{0} 00:00'.format(elements[4]), timefrm)
        elements[5] = elements[5].rstrip('\n').split (':')
        elements[6] = parsefonts (elements[6]) # Parse the fonts
        data.append (elements)

# Walk throuhg the lines and draw!
for line in data:
    if (isinstance(line[3], datetime) and isinstance(line[4], datetime)):
        #drawBag (p = getPosition (line), w = getWidth (line), h = getHeight (line), r = getRoundness(line), c = getColor (line))
        insert = getPosition (line)
        plot.add(plot.text(text = line[0], insert=insert, transform="rotate(-90,{0},{1})".format(insert[0], insert[1])))

# Save file, with respect to UTF-8 encoding
output = codecs.open(resultfile, "w", "UTF-8")
output.write(plot.tostring())
output.close()
