%computeAAfromRM.m
function [t, n] = computeAAfromRM(R)
%rm = eye(3) + (sin(t)*nhat) + (1-cos(t))*nhat^2;

t = acos((trace(R)-1)/2);
v = @(m) [-m(2,3); m(1,3); -m(1,2)];
n = (1/(2*sin(t)))*v(R-R');
if trace(R) == 3
    n = (1/sqrt(3))*[1;1;1];
end
end