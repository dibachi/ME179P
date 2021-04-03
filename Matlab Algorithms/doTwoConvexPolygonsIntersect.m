%doTwoConvexPolygonsIntersect.m
function outvar = doTwoConvexPolygonsIntersect(P1,P2)
for i = 1:length(P1)
    if isPointInConvexPolygon(P1(i,:),P2) == true
        outvar = true;
        return
    end
    for j = 1:length(P2)
        if isPointInConvexPolygon(P2(j,:),P1) == true
            outvar = true;
            return
        end
        if i == length(P1) && j == length(P2)
            cond = doTwoSegmentsIntersect(P1(i,:),P1(1,:),P2(j,:),P2(1,:));
        elseif i == length(P1)
            cond = doTwoSegmentsIntersect(P1(i,:),P1(1,:),P2(j,:),P2(j+1,:));
        elseif j == length(P2)
            cond = doTwoSegmentsIntersect(P1(i,:),P1(i+1,:),P2(j,:),P2(1,:));
        else
            cond = doTwoSegmentsIntersect(P1(i,:),P1(i+1,:),P2(j,:),P2(j+1,:));
        end
        if cond == true
            outvar = true;
            return
        end
    end            
end
outvar = false;