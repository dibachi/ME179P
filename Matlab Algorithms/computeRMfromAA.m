%computeRMfromAA.m
function rm = computeRMfromAA(t,n)
tol = 1e-8;
if t > pi || t < 0
    error('theta is outside the bounds [0, pi]')
end
if norm(n) > 1+tol || norm(n) < 1-tol
    error('n is not a unit vector')
end
nhat = [0 -n(3) n(2); n(3) 0 -n(1); -n(2) n(1) 0];
rm = eye(3) + (sin(t)*nhat) + (1-cos(t))*nhat^2;
end