import svgwrite
import datetime

# data {
#   'creationDate': %Y-%m-%d %H:%M
#   'maxDate': %Y-%m-%d %H:%M
# ? 'roundness': [0-1]
#
# }

timefrm = '%Y-%m-%d %H:%M'
outputSize = (500, 500) # [width, height]
timeGrid = [datetime.strptime ('1998-01-01 00:00', timefrm), datetime.today()]
gridTimeSpan = timeGrid[1] - timeGrid[0]
pixelGrid = ((0,0), outputSize) # (x,y), (x,y)

plot = svgwrite.Drawing (filename = resultfile, size = (grid[2], grid[3]), viewBox = "0 0 " + str (grid[2]) + " " + str (grid[3]))

for line in data:
    line['maxDate'] = datetime.strptime ('maxDate', timefrm)
    line['creationDate'] = datetime.strptime ('creationDate', timefrm)
    drawBag (position = getPosition (line), width = getWidth (line), height = getHeight (line), roundness = getRoundness(line), color = getColor (line))

def drawBag (position = position, width = width, height = height, roundness = roundness, color = color):
    bag = drawing.path ()
    bag.push ("M "

def getPosition (data):
    timeOffset = data['creationDate'] - timeGrid[0]
    x = (timeOffset.days () / gridTimeSpan.days()) * outputSize[1][0]
    y = outputSize[1] / 2

    return (x, y) 

def getWidth (data):
    timeSpan = data['maxDate'] - data['creationDate']

    return (timeSpan.days() / gridTimeSpan.days ()) * outputSize[1][0]

def getHeight (data):
    return 20

def getRoundness (data):
    return 0.5
