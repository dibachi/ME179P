function returns = computeDistancePointToPolygon(P,q)
numverts = numel(P(:,1));
distances = zeros(numverts,1);
for i = 1:numverts
    p1 = P(i,:);
    if i == numverts
        p2 = P(1,:);
    else
        p2 = P(i+1,:);
    end
    distances(i) = computeDistancePointToSegment(q,p1,p2);
end
returns = min(distances);
perx = P(:,1); pery = P(:,2);
qx = q(1); qy = q(2);
[in, on] = inpolygon(qx,qy,perx,pery);
if in == 1 && on == 0
%     warning('The point q is inside the polygon. A path out is not possible.');
    returns = NaN;
end
if on == 1
%     warning('The point q is on the polygon boundary.');
end

end