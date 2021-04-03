%isPointInConvexPolygon.m
function outvar = isPointInConvexPolygon(q,P)
vertices = length(P);
intnorms = zeros(vertices,2);
cond = zeros(vertices,1);
for i = 1:vertices
    if i == vertices
        intnorms(i,:) = [-(P(1,2) - P(i,2)), (P(1,1) - P(i,1))];
    else
        intnorms(i,:) = [-(P(i+1,2) - P(i,2)), (P(i+1,1) - P(i,1))];
    end
    cond(i) = intnorms(i,:) * [(q(1) - P(i,1)), (q(2) - P(i,2))]';
    if cond(i) < 0
        outvar = false;
        return
    end
end  
outvar = true;
end