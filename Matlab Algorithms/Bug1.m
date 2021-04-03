%function [Loc, Time] = computeBug1Path(Polygons,start,goal)

clear; clc; clf;

stepsize = 0.1;
obstaclesList={{[1,2],[1,0],[3,0]},{[2,3],[4,1],[5,2]}};
xs = [];
ys = [];
xlist = {};
ylist = {};
Polygons = {};
for i = 1:length(obstaclesList)
    xs = [];
    ys = [];
    for j = 1:length(obstaclesList{i})
        xs = [xs obstaclesList{i}{j}(1)];
        ys = [ys obstaclesList{i}{j}(2)];
    end
    Polygons = {Polygons{:},xs,ys};
end

% Polygons = {[1, 1, 3] [2, 0, 0] [2, 10, 2.5, 2] [2, 2, 2.5, 4]};
% AdjTable = {[2] [1, 3, 4] [2, 5] [2] [3]}
pos = [0; 0];
goal = [5; 3];
posvect = pos;
pos2goal = [goal(1),goal(1);pos(1),pos(2)];
dist = pdist(pos2goal,'euclidean');



while dist > stepsize 
    pos2goal = [goal(1),goal(2);pos(1),pos(2)];
    dist = pdist(pos2goal,'euclidean');
    alldispoly = zeros(1,length(Polygons)/2);
    xstep = stepsize*(goal(1)-pos(1))/pdist(pos2goal,'euclidean');
    ystep = stepsize*(goal(2)-pos(2))/pdist(pos2goal,'euclidean');
    
    for i = 1:length(Polygons)/2
        alldistpoly(i) = computeDistancePointToPolygon([Polygons{2*i-1};Polygons{2*i}]',pos);
    end
    
    [distpoly polynum] = min(alldistpoly);

    if isnan(computeDistancePointToPolygon([Polygons{2*polynum-1};Polygons{2*polynum}]',[pos(1)+xstep;pos(2)+ystep])) == 1
        polyvect = pos;
        pos2goal = [goal(1),goal(2);pos(1),pos(2)];
        polydist = pdist(pos2goal,'euclidean');
        start = pos;
        [q ufin] = computeTangentVectorToPolygon([Polygons{2*polynum-1};Polygons{2*polynum}]',pos);
        xstep = stepsize*ufin(1);
        ystep = stepsize*ufin(2);
        pos = [pos(1)+xstep; pos(2)+ystep];
        posvect = [posvect pos];
        polyvect = [polyvect pos];
        pos2goal = [goal(1),goal(2);pos(1),pos(2)];
        polydist = [polydist pdist(pos2goal,'euclidean')];
        while sqrt((start(1)-pos(1))^2+(start(2)-pos(2))^2)>stepsize/2
            for j = 1:length(Polygons)/2
                pos2goal = [goal(1),goal(2);pos(1),pos(2)];
                disttopoly = computeDistancePointToPolygon([Polygons{2*polynum-1};Polygons{2*polynum}]',pos);
                [q ufin] = computeTangentVectorToPolygon([Polygons{2*polynum-1};Polygons{2*polynum}]',pos);
                if disttopoly < stepsize
                    xstep = stepsize*ufin(1);
                    ystep = stepsize*ufin(2);
                else
                    t = pi/8;
                    gstep = [cos(t) -sin(t);sin(t) cos(t)]*[stepsize*ufin(1); stepsize*ufin(2)];
                    xstep = gstep(1);
                    ystep = gstep(2);
                end
                pos = [pos(1)+xstep; pos(2)+ystep];
                posvect = [posvect pos];
                polyvect = [polyvect pos];
                polydist = [polydist pdist(pos2goal,'euclidean')];
            end
        end
        pos2goal = [goal(1),goal(2);pos(1),pos(2)];
        [mindist minindex] = min(polydist);
        posvect = [posvect polyvect(:,1:minindex)];
        pos = polyvect(:,minindex);
        xstep = stepsize*(goal(1)-pos(1))/pdist(pos2goal,'euclidean');
        ystep = stepsize*(goal(2)-pos(2))/pdist(pos2goal,'euclidean');
        pos = [pos(1)+xstep; pos(2)+ystep]
        posvect = [posvect pos];
    end
   
            
    if dist > stepsize && isnan(computeDistancePointToPolygon([Polygons{2*polynum-1};Polygons{2*polynum}]',[pos(1)+xstep;pos(2)+ystep])) == 0
        if isnan(computeDistancePointToPolygon([Polygons{2*polynum-1};Polygons{2*polynum}]',[pos(1)+2*xstep;pos(2)+2*ystep])) == 1
            newstepsize = 0.05*stepsize;
            xstep = newstepsize*(goal(1)-pos(1))/pdist(pos2goal,'euclidean');
            ystep = newstepsize*(goal(2)-pos(2))/pdist(pos2goal,'euclidean');
            disp('boop')
        else
            xstep = stepsize*(goal(1)-pos(1))/pdist(pos2goal,'euclidean');
            ystep = stepsize*(goal(2)-pos(2))/pdist(pos2goal,'euclidean');
        end
        pos = [pos(1)+xstep; pos(2)+ystep];
        posvect = [posvect pos];
    end
end

posvect = [posvect goal];
disp(pos);
plot(0,0,'ro');
hold on
plot(goal(1),goal(2),'ro');
hold on
plot(posvect(1,:),posvect(2,:),'*');
hold on
for i = 1:length(Polygons)/2
    fill(Polygons{2*i-1},Polygons{2*i},[0,0,1]);
end
