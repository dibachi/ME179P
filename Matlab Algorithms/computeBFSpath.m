% Input: a graph described by its adjacency table AdjTable, a start node
% and a goal node
%
% Output: a vector containing the nodes on a shortest path from the start
% to the goal
%
% AdjTable is a cell array where the i-th element in the cell is a vector
% containing the neighbor nodes of node i, start is an integer between 1
% and length(AdjTable), goal is an integer between 1 and length(AdjTable)

function P = computeBFSpath(AdjTable, start, goal)
parent = computeBFStree(AdjTable,start); %creates vector with the parent of each node
P = [goal]; %starts path vector
u = goal; %start with goal and work backwards to start point
if isnan(parent(u)) %true if the goal is on a separate graph from the start 
    error('The tree is separated into two or more groups. A path from start to goal is not possible.')
end
while parent(u) ~= u %while not at the start point, where the parent is equal to itself
    u = parent(u); %reassign u by going backwards from goal to start
    P = [u P]; %place u at the front of the path vector
end
%when parent(u) == u, function runs to completion and returns path vector P
end