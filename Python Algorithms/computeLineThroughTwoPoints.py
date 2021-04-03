#computeLineThroughTwoPoints.py
import numpy as np

def computeLineThroughTwoPoints(p1,p2):
    if p1.size != 2 or p2.size != 2:
        status = 'point input arguments must be in two dimensional space'
    else:
        status = 'it\'s fine'
    print(status)

p1 = np.array([1,2,3])
p2 = np.array([2,3])
computeLineThroughTwoPoints(p1,p2)
