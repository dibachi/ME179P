%scrapcode.m

start = [0,0]; goal = [5,3];
O1 = {[1, 2], [1, 0], [3, 0]};
O2 = {[2, 3], [4, 1], [5, 2]};
obstacles = {O1, O2};
step = 0.1;

O1 = zeros(length(obstacles{1}),2);
O2 = zeros(length(obstacles{2}),2);
for k = 1:length(obstacles)
    for i = 1:length(obstacles{k})
        if k == 1
            O1(i,1) = obstacles{k}{i}(1);
            O1(i,2) = obstacles{k}{i}(2);
        end
        if k == 2
            O2(i,1) = obstacles{k}{i}(1);
            O2(i,2) = obstacles{k}{i}(2);
        end
    end
end
dx = 0.1; dy = 0.2; 
dc = [dx,dy];
current = [5, 10];
buh = current+dc

% O1(:,1:2) = obstacles{1}{1:3}(1:2);
% % O1(:,2) = obstaclesList{1}{:}(2);
% O2(:,1:2) = obstacles{2}{1:3}(1:2);