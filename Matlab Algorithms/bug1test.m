%bug1test.m
clf
clear
start = [0,0]; goal = [5,3];
O1 = {[1, 2], [1, 0], [3, 0]};
O2 = {[2, 3], [4, 1], [5, 2]};
obstacles = {O1, O2};
step = 0.1;
tic
path = computeBug1(start,goal,obstacles,step);
toc
t = toc;
bpath = BugBase(start,goal,obstacles,step);
for j = 1:(length(path(:,1))-1)
    leng(j) = sqrt((path(j,1)-path(j+1,1))^2 + (path(j,2)-path(j+1,2))^2);
end
total = sum(leng);
fprintf('path length = %2.2f \n', total);
figure(1)
plot(path(:,1),path(:,2),'k.')
xlabel('x');
ylabel('y');
title('Bug 1 Map');
% axis([0 5 0 3])
dist = zeros(1,length(path(:,1)));
for i = 1:length(path(:,1))
    dist(i) = sqrt((goal(1)-path(i,1))^2 + (goal(2)-path(i,2))^2);
end
time = linspace(0,t,length(path(:,1)));
figure(2)
plot(time,dist,'k')
xlabel('time (s)');
ylabel('distance');
title('Distance from Goal vs. Time');

