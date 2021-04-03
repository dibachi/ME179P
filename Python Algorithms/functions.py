#functions.py
import math
import numpy as np
from sympy import *
"""This is a repository of all the functions made for ME179P"""
def computeLineThroughTwoPoints(p1,p2):
    if p1.size != 2 or p2.size != 2:
        raise Exception('Point input arguments must be in two dimensional space.')
    x1 = p1[0]
    y1 = p1[1]
    x2 = p2[0]
    y2 = p2[1]
    g = math.sqrt((y2-y1)**2 + (x2-x1)**2)
    tol = 1e-8
    if abs(y2-y1) <= tol and abs(x2-x1) <=tol:
        raise Exception('Input points are coincident. A line cannot be formed.')
    a = -(y2-y1)/g
    b = (x2-x1)/g
    c = -((y1*(x2-x1))-(x1*(y2-y1)))/g
    return np.array([a,b,c])

def computeDistancePointToLine(q,p1,p2):
    if q.size != 2 or p1.size != 2 or p2.size != 2:
        raise Exception('Point input arguments must be in two dimensions.')
    x1 = p1[0]
    y1 = p1[1]
    x2 = p2[0]
    y2 = p2[1]
    qx = q[0]
    qy = q[1]
    tol = 1e-8
    if abs(y2-y1) <= tol and abs(x2-x1) <=tol:
        raise Exception('Input points are coincident. A line cannot be formed.')
    a = -(y2-y1)
    b = (x2-x1)
    c = -((y1*(x2-x1))-(x1*(y2-y1)))
    d = -b
    e = a
    f = (qy*(y2-y1))+(qx*(x2-x1))
    A = np.array([[a, b], [d, e]])
    B = np.array([[-c],[-f]])
    M = Matrix(np.hstack((A,B)))
    S = M.rref()[0]
    intx = S[0,2]
    inty = S[1,2]
    dist = math.sqrt((intx-qx)**2 + (inty-qy)**2)
    return dist

def computeDistancePointToSegment(q,p1,p2):
    if q.size != 2 or p1.size != 2 or p2.size != 2:
        raise Exception('Point input arguments must be in two dimensions.')
    x1 = p1[0]
    y1 = p1[1]
    x2 = p2[0]
    y2 = p2[1]
    qx = q[0]
    qy = q[1]
    tol = 1e-8
    if abs(y2-y1) <= tol and abs(x2-x1) <=tol:
        raise Exception('Input points are coincident. A line cannot be formed.')
    a = -(y2-y1) 
    b = (x2-x1)
    c = -((y1*(x2-x1))-(x1*(y2-y1)))
    d = -b 
    e = a 
    f = (qy*(y2-y1))+(qx*(x2-x1))
    A = np.array([[a, b], [d, e]])
    B = np.array([[-c],[-f]])
    M = Matrix(np.hstack((A,B)))
    S = M.rref()[0]
    intx = S[0,2]
    inty = S[1,2]
    dist0q = math.sqrt((intx-qx)**2+(inty-qy)**2)
    dist1q = math.sqrt((x1-qx)**2+(y1-qy)**2)
    dist2q = math.sqrt((x2-qx)**2+(y2-qy)**2)
    dist12 = math.sqrt((x1-x2)**2+(y1-y2)**2)
    dist01 = math.sqrt((x1-intx)**2+(y1-inty)**2)
    dist02 = math.sqrt((x2-intx)**2+(y2-inty)**2)
    if abs((dist01+dist02)-dist12) > tol:
        if dist01 < dist02:
            w = 1
            dist = dist1q
        else:
            w = 2
            dist = dist2q
    else:
        w = 0
        dist = dist0q
    return [dist,w]

def isPointInConvexPolygon(q,P):
    vertices = len(P)
    intnorms = np.zeros((vertices,2))
    cond = np.zeros((vertices,1))
    for i in range(0,vertices-1):
        if i == vertices:
            intnorms[i,:] = np.array([-(P[0,1] - P[i,1], (P[0,0] - P(i,0]])
        else:
            intnorms[i,:] = np.array([-(P[0,1] - P[i+1,1], (P[0,0] - P(i+1,0]])
        modifier = np.array([(q[0] - P[i,0]), (q[1] - P[i,1])])
        cond[i] = intnorms[i,:] * np.transpose(modifier)
        if cond[i] < 0:
            return False
    return True

