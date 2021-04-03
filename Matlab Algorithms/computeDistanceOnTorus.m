function dist = computeDistanceOnTorus(p1,p2)

a1 = p1(1); b1 = p1(2);
a2 = p2(1); b2 = p2(2);

adist = acos(cos(a1)*cos(a2) + sin(a1)*sin(a2));
bdist = acos(cos(b1)*cos(b2) + sin(b1)*sin(b2));

dist = sqrt(adist^2+bdist^2);
end