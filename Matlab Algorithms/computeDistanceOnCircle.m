function angle = computeDistanceOnCircle(t1,t2)

angle = acos(cos(t1)*cos(t2) + sin(t1)*sin(t2));
end