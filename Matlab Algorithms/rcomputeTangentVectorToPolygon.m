function tang = computeTangentVectorToPolygon(P,q)
numverts = numel(P(:,1));
distances = zeros(numverts,1);
cases = zeros(numverts,1);
for i = 1:numverts
    p1 = P(i,:);
    if i == numverts
        p2 = P(1,:);
    else
        p2 = P(i+1,:);
    end
    [distances(i),cases(i)] = computeDistancePointToSegment(q,p1,p2);
end
perx = P(:,1); pery = P(:,2);
qx = q(1); qy = q(2);
[in, on] = inpolygon(qx,qy,perx,pery);
if in == 1 && on == 0
    warning('The point q is inside the polygon. A path out is not possible.');
end
if on == 1
    warning('The point q is on the polygon boundary.');
end
[closest,ind] = min(distances);
dubs = cases(ind);
if dubs == 0
    po1 = P(ind,:); 
    if ind == numverts
        po2 = P(1,:);
    else
        po2 = P(ind+1,:);
    end
    x1 = po1(1); y1 = po1(2); x2 = po2(1); y2 = po2(2); 
    a = -(y2-y1); b = (x2-x1); c = -((y1*(x2-x1))-(x1*(y2-y1)));
    d = -b; e = a; f = (qy*(y2-y1))+(qx*(x2-x1));
    A = [a b; d e]; B = [-c; -f]; M = [A B];
    S = rref(M); intx = S(1,3); inty = S(2,3);
    
    if on == 1
        if abs([intx inty] - P(1,:)) < 1e-8
            tang = [(intx-x2);(inty-y2)]./sqrt((x2-intx)^2 + (y2-inty)^2);
        else
            tang = [(x1-intx);(y1-inty)]./sqrt((x1-intx)^2 + (y1-inty)^2);
        end
    else
        tang = [-(qy-inty);(qx-intx)]./sqrt((qx-intx)^2 + (qy-inty)^2);
    end
else 
    if dubs == 1
        po = P(ind,:);
    else
        po = P(ind+1,:);
    end
    tang = [-(qy-po(2));(qx-po(1))]./sqrt((qx-po(1))^2 + (qy-po(2))^2);
end
end