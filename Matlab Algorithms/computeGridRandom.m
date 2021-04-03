% This function computes the coordinates of the sample points in the random
% sampling scheme. n is an integer number. P(i,j) and Q(i,j) are the
% x-coorinate and y-coordinate of the same sampling point (i,j),
% respectively.

function [P,Q] = computeGridRandom(n)
P = rand(n,1);
Q = rand(n,1);
end