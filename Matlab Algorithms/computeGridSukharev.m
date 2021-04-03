%computeGridSukharev.m
% This function computes the coordinates of the sample points in the
% uniform Sukharev center grid. n is a square number. P(i,j) and Q(i,j) are
% the x-coorinate and y-coordinate of the same sampling point (i,j),
% respectively.
function [P,Q] = computeGridSukharev(n)
k = sqrt(n);
P = zeros(k);
Q = zeros(k);

for i = 1:k
    for j = 1:k
        P(i,j) = j/k - 1/(2*k);
        Q(j,i) = j/k - 1/(2*k);
    end
end
end