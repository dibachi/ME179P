function returns = computeLineThroughTwoPoints(p1,p2)
if numel(p1) ~= 2 || numel(p2) ~= 2
    error('point input arguments must be vectors of two elements each');
end
x1 = p1(1); y1 = p1(2); x2 = p2(1); y2 = p2(2);
g = sqrt((y2-y1)^2 + (x2-x1)^2); 
tol = 1e-8;
if abs(y2-y1) <= tol && abs(x2-x1) <= tol
    error('input points are coincident. cannot form line');
end
a = -(y2-y1)/g; b = (x2-x1)/g; c = -((y1*(x2-x1))-(x1*(y2-y1)))/g;%-int*(x2-x1);
returns(1) = a; returns(2) = b; returns(3) = c;
end