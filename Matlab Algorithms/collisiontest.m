%collisiontest.m
clc
P1 = [0 0; 4 0; 4 4; 0 4];
P2 = [1 1; 4 1; 4 3; 1 3];
P3 = [2 2; 4 2; 4 4; 2 4];
P4 = [6 1; 6 2; -1 1];
doTwoConvexPolygonsIntersect(P1,P4)