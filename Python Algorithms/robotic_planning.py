#robotic_planning.py
import math
import numpy as np
from sympy import *
"""This module contains all the planning functions I made for my ME179P class.
The functions were originally written in MATLAB, as that is what I was most familiar 
with at the time. I have rewritten them in Python as an exercise to become more fluent 
in Python, and to have the algorithms ready to use in future projects."""
def computeLineThroughTwoPoints(p1,p2):
    #this function assumes points are in R2. If they are not, an exception is raised
    if p1.size != 2 or p2.size != 2:
        raise Exception('Point input arguments must be in two dimensional space.')
    #assign x and y labels to the first and second elements of each input point
    x1 = p1[0]
    y1 = p1[1]
    x2 = p2[0]
    y2 = p2[1]
    #find the Euclidean distance between the two points
    g = math.sqrt((y2-y1)**2 + (x2-x1)**2)
    #declare a FLOP tolerance value. if the two input points are coincident (less than FLOP tol.), raise an exception
    tol = 1e-8
    if abs(y2-y1) <= tol and abs(x2-x1) <=tol:
        raise Exception('Input points are coincident. A line cannot be formed.')
    #calculate and return a, b, and c according to ay + bx = c, but normalized by g
    a = -(y2-y1)/g
    b = (x2-x1)/g
    c = -((y1*(x2-x1))-(x1*(y2-y1)))/g
    return np.array([a,b,c])

def computeDistancePointToLine(q,p1,p2):
    #raise exception if points are not in R2
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
    #find a, b, and c according to ay + bx = c
    a = -(y2-y1)
    b = (x2-x1)
    c = -((y1*(x2-x1))-(x1*(y2-y1)))
    #find the line perpendicular to that given by p1 and p2 which goes through q
    d = -b
    e = a
    f = (qy*(y2-y1))+(qx*(x2-x1))
    #set up a system of equations and find the solution (point of intersection)
    A = np.array([[a, b], [d, e]])
    B = np.array([[-c],[-f]])
    M = Matrix(np.hstack((A,B)))
    S = M.rref()[0]
    #grab the x and y coordinates of the intersection and calculate the distance from int to q
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
    """There are many possibilities for the closest distance from the point to the segment.
    The point can be closest to either the line or one of the segment's endpoints."""
    dist0q = math.sqrt((intx-qx)**2+(inty-qy)**2)
    dist1q = math.sqrt((x1-qx)**2+(y1-qy)**2)
    dist2q = math.sqrt((x2-qx)**2+(y2-qy)**2)
    #calculate line length, length from int to p1, and int to p2
    dist12 = math.sqrt((x1-x2)**2+(y1-y2)**2)
    dist01 = math.sqrt((x1-intx)**2+(y1-inty)**2)
    dist02 = math.sqrt((x2-intx)**2+(y2-inty)**2)
    #if true, then the point q is closer to one of the endpoints than the segment itself
    if abs((dist01+dist02)-dist12) > tol:
        if dist01 < dist02:
            #point q is closest to p1. return the appropriate distance and status w
            w = 1
            dist = dist1q
        else:
            #point q is closest to p2
            w = 2
            dist = dist2q
    else:
        #the point q is closest to the segment rather than its endpoints. return w = 0
        w = 0
        dist = dist0q
    return [dist,w]

def isPointInConvexPolygon(q,P):
    """This function determines if the point q is within the CONVEX polygon specified by array P
    of polygon vertices listed counterclockwise."""
    #grab the number of vertices
    vertices = len(P)
    #initialize array of internal normal vectors in R2 (one vector for each side)
    intnorms = np.zeros((vertices,2))
    
    for i in range(0,vertices-1):
        #if we are on vertex number four of a square for example, then compute the 
        #interior normal by using the first and last point to form the segment
        if i == vertices:
            #intnorm = [-y, x]
            intnorms[i,:] = np.array([-(P[0,1] - P[i,1]), (P[0,0] - P[i,0])])
        #otherwise, go counterclockwise around polygon to form interior normals to each side
        else:
            #intnorm = [-y, x]
            intnorms[i,:] = np.array([-(P[i+1,1] - P[i,1]), (P[i+1,0] - P[i,0])])
        #vector from vertex i to point q
        vertex_to_q = np.array([(q[0] - P[i,0]), (q[1] - P[i,1])])
        #if the dot product between the two vectors is less than 0, the point is not in the polygon
        cond = np.dot(intnorms[i,:], vertex_to_q)
        if cond < 0:
            return False
    return True

