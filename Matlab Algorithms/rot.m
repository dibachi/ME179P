%rot.m
rotx = @(t) [1 0 0; 0 cos(t) -sin(t); 0 sin(t) cos(t)];
roty = @(t) [cos(t) 0 sin(t); 0 1 0; -sin(t) 0 cos(t)];
rotz = @(t) [cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];
r = rotx(-pi/2)*roty(-pi/2);
buh = [0 0 -1 0; -1/2 sqrt(3)/2 0 -sqrt(3); sqrt(3)/2 1/2 0 -1; 0 0 0 1];
duh = [1/2 0 sqrt(3)/2 1; 0 1 0 -1; -sqrt(3)/2 0 1/2 0; 0 0 0 1];
yo = buh*duh;
roty(pi/3)
    