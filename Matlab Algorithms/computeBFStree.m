% Input: a graph described by its adjacency table AdjTable and a start node
% Output: a vector of pointers parents describing the BFS tree rooted at
% start
%
% AdjTable is a cell array where the i-th element in the cell is a vector
% containing the neighbor nodes of node i, start is an integer between 1
% and length(AdjTable)

function parent = computeBFStree(AdjTable,start)
Q = [start]; %store vstart in the queue Q
parent = NaN(1,length(AdjTable)); %sets the parent node of all to NaN (represents 'none')
parent(start) = start; %sets the parent of the start node as itself
while isempty(Q) == 0 %while the queue is empty (still has connected nodes with unassigned 
    v = Q(1); %v becomes first element of the queue
    neighbors = AdjTable{v}; %looking for neighbors at node v
    for i = 1:length(neighbors) %for all v's neighbors
        u = neighbors(i); %start with v's first neighbor
        if isnan(parent(u)) %check if it has not been parented yet
            parent(u) = v; %assign u its parent v
            Q = [Q u]; %place u at the back of the queue
        end
    end
    Q(1) = []; %after parenting all v's neighbors, remove v from the queue
end
end