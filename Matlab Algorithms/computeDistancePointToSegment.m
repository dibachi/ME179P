function [dist,w] = computeDistancePointToSegment(q,p1,p2)
if numel(p1) ~= 2 || numel(p2) ~= 2 || numel(q) ~= 2
    error('point input arguments must be vectors of two elements each');
end
x1 = p1(1); y1 = p1(2); x2 = p2(1); y2 = p2(2); qx = q(1); qy = q(2);
tol = 1e-8;
if abs(y2-y1) <= tol && abs(x2-x1) <= tol
    error('p1 and p2 are coincident. cannot form line');
end
a = -(y2-y1); b = (x2-x1); c = -((y1*(x2-x1))-(x1*(y2-y1)));
d = -b; e = a; f = (qy*(y2-y1))+(qx*(x2-x1));
A = [a b; d e]; B = [-c; -f]; M = [A B];
S = rref(M); intx = S(1,3); inty = S(2,3);
dist0q = sqrt((intx-qx)^2+(inty-qy)^2);
dist1q = sqrt((x1-qx)^2+(y1-qy)^2);
dist2q = sqrt((x2-qx)^2+(y2-qy)^2);
dist12 = sqrt((x1-x2)^2+(y1-y2)^2);
dist01 = sqrt((x1-intx)^2+(y1-inty)^2);
dist02 = sqrt((x2-intx)^2+(y2-inty)^2);
if abs((dist01+dist02)-dist12) > tol
    if dist01 < dist02
        w = 1;
        dist = dist1q;
    else
        w = 2;
        dist = dist2q;
    end
else
    w = 0;
    dist = dist0q;
end
end