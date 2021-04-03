function returns = computeDistancePointToLine(q,p1,p2)
if numel(p1) ~= 2 || numel(p2) ~= 2 || numel(q) ~= 2
    error('point input arguments must be vectors of two elements each');
end
x1 = p1(1); y1 = p1(2); x2 = p2(1); y2 = p2(2); qx = q(1); qy = q(2);
tol = 1e-8;
if abs(y2-y1) <= tol && abs(x2-x1) <= tol
    error('points are coincident. cannot form line');
end
a = -(y2-y1); b = (x2-x1); c = -((y1*(x2-x1))-(x1*(y2-y1)));
d = -b; e = a; f = (qy*(y2-y1))+(qx*(x2-x1));
A = [a b; d e]; B = [-c; -f]; M = [A B];
S = rref(M); intx = S(1,3); inty = S(2,3);
dist = sqrt((intx-qx)^2+(inty-qy)^2);
returns = dist;
end
