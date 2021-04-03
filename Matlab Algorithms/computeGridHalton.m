% This function computes the coordinates of the sample points in the Halton
% samling scheme. n is an integer number, b1 and b2 are prime numbers.
% P(i,j) and Q(i,j) are the x-coorinate and y-coordinate of the same
% sampling point (i,j), respectively.


function [P,Q] = computeGridHalton(n,b1,b2)
S = zeros(1,n);
W = zeros(1,n);
for i = 1:n
    i_tmp = i;
    f1 = 1/b1;
    while i_tmp > 0
        r1 = mod(i_tmp,b1);
        q1 = (i_tmp/b1) - (r1/b1);
        S(i) = S(i) + f1*r1;
        i_tmp = q1;
        f1 = f1/b1;
    end
    
end
for j = 1:n
    i_tmp = j;
    f2 = 1/b2;
    while i_tmp > 0
        r2 = mod(i_tmp,b2);
        q2 = (i_tmp/b2) - (r2/b2);
        W(j) = W(j) + f2*r2;
        i_tmp = q2;
        f2 = f2/b2;
    end
    
end
P = S; Q = W;
end