function path = BugBase(start,goal,obstaclesList,stepsize)
current = start; path = [start]; 
dist = sqrt((current(1)-goal(1))^2 + (current(2) - goal(2))^2);
N = length(obstaclesList);
currenttoobstacle = zeros(1,N);
O1 = zeros(length(obstaclesList{1}),2);
O2 = zeros(length(obstaclesList{2}),2);
for k = 1:length(obstaclesList)
    for i = 1:length(obstaclesList{k})
        if k == 1
            O1(i,1) = obstaclesList{k}{i}(1);
            O1(i,2) = obstaclesList{k}{i}(2);
        end
        if k == 2
            O2(i,1) = obstaclesList{k}{i}(1);
            O2(i,2) = obstaclesList{k}{i}(2);
        end
    end
end
reformedList = {O1, O2};
while dist > stepsize
    dist = sqrt((current(1)-goal(1))^2 + (current(2) - goal(2))^2);
    dx = (stepsize/dist)*(goal(1)-current(1));
    dy = (stepsize/dist)*(goal(2)-current(2));
    dcurrent = [dx, dy];
    for i = 1:N
        currenttoobstacle(i) = computeDistancePointToPolygon(reformedList{i},current);
    end
    [dpoly, indpoly] = min(currenttoobstacle);
    if indpoly == 1
        obstacle = O1;
    end
    if indpoly == 2
        obstacle = O2;
    end
    if isnan(computeDistancePointToPolygon(obstacle,current+dcurrent))
        fprintf('Failure: there is an obstacle lying between start and goal \n');
        return
    end
    
    if dist > stepsize && ~isnan(computeDistancePointToPolygon(obstacle,current+[dx,dy]))
        if isnan(computeDistancePointToPolygon(obstacle,current+[2*dx,2*dy]))
            smallstep = 0.05*stepsize;
            dx = (smallstep/dist)*(goal(1)-current(1));
            dy = (smallstep/dist)*(goal(2)-current(2));
        else
            dx = (stepsize/dist)*(goal(1)-current(1));
            dy = (stepsize/dist)*(goal(2)-current(2));
        end
        current = current + [dx,dy];
        path = [path; current];
    end
end
path = [path; goal];
fprintf('Success! \n');   
end