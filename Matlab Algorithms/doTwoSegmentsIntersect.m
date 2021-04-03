%doTwoSegmentsIntersect.m
function [tf,intpoint] = doTwoSegmentsIntersect(p1,p2,p3,p4)
x1 = p1(1); x2 = p2(1); x3 = p3(1); x4 = p4(1);
y1 = p1(2); y2 = p2(2); y3 = p3(2); y4 = p4(2);

numa = (x4-x3)*(y1-y3) - (y4-y3)*(x1-x3);
dena = (y4-y3)*(x2-x1) - (x4-x3)*(y2-y1);

numb = (y1-y3)*(x2-x1) + (y2-y1)*(x3-x1);
denb = (y4-y3)*(x2-x1) - (y2-y1)*(x4-x3);

if numa == 0 && dena == 0
    %lines are coincident. still need to check intersection
    [dist3, w3] = computeDistancePointToSegment(p3,p1,p2);
    [dist4, w4] = computeDistancePointToSegment(p4,p1,p2);
    if dist3 == 0 || dist4 == 0
        %lines are overlapping. return any of the points in the overlap
        %range
        tf = true;
        if dist3 == 0
            intpoint = p3;
%             if w4 == 0
%                 intpoint = [p3; p4];
%             elseif w4 == 1
%                 intpoint = [p3; p1];
%             else
%                 intpoint = [p3; p2];
%             end
        else
            intpoint = p4;
%             if w3 == 0
%                 intpoint = [p4; p3];
%             elseif w3 == 1
%                 intpoint = [p4; p1];
%             else
%                 intpoint = [p4; p2];
%             end
        end
    else
    tf = false;
    intpoint = [NaN, NaN];
    end
elseif numa ~= 0 && dena == 0
    %parallel. no intersection
    tf = false;
    intpoint = [NaN, NaN];
elseif dena ~= 0
    %not parallel. still need to check intersection
    sa = numa/dena;
    sb = numb/denb;
    if sa < 0 || sa > 1
        tf = false;
        intpoint = [NaN, NaN];
    elseif sb < 0 || sb > 1
        tf = false;
        intpoint = [NaN, NaN];
    else
    pax = x1 + sa*(x2-x1); pay = y1 + sa*(y2-y1);
    tf = true;
    intpoint = [pax, pay];
    end
end
end