function route = DijkstraTorus (input_map, start_coords, dest_coords, drawMap)
% Run Dijkstra's algorithm on a grid.
% Inputs :
%   input_map : a logical array where the freespace cells are false or 0 and
%      the obstacles are true or 1
%   start_coords and dest_coords : Coordinates of the start and end cell
%       respectively, the first entry is the row and the second the column.
% Output :
%   route : An array containing the linear indices of the cells along the
%    shortest route from start to dest or an empty array if there is no
%    route.

% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

cmap = [1 1 1; ...
    0 0 0; ...
    1 0 0; ...
    0 0 1; ...
    0 1 0; ...
    1 1 0];

colormap(cmap);


[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~input_map) = 1;  % Mark free cells
map(input_map)  = 2;  % Mark obstacle cells

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));

map(start_node) = 5;
map(dest_node)  = 6;

% Initialize distance array
distances = Inf(nrows,ncols);

% For each grid cell this array holds the index of its parent
parent = zeros(nrows,ncols);

distances(start_node) = 0;

% Main Loop
while true
    
    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;
    
    if drawMap
        image(1.5, 1.5, map);
        grid on;
        axis image;
        drawnow;
    end
    
    % Find the node with the minimum distance
    [min_dist, current] = min(distances(:));
    
    if ((current == dest_node) || isinf(min_dist))
        break
    end
    
    % Update map
    map(current) = 3;         % mark current node as visited
    distances(current) = Inf; % remove this node from further consideration
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(distances), current);
    
    % Visit each neighbor of the current node and update the map, distances
    % and parent tables appropriately.
    
    %%% All of your code should be between the two lines of stars.
    % *******************************************************************
   
    % North
    if (mod(current-1,nrows)~=0)  %(current-1)>0 && 
        if (map(current-1)==1 || map(current-1)==6)
            map(current-1) = 4;
            distances(current-1)=min_dist+1;
            parent(current-1)=current;
        end
    else
        if (map(current-1+nrows)==1 || map(current-1+nrows)==6)
            map(current-1+nrows) = 4;
            distances(current-1+nrows)=min_dist+1;
            parent(current-1+nrows)=current;
        end
    end
    
    % South
    if ( mod(current+1,nrows)~=1)  %(current+1)<=nrows*ncols &&
        if (map(current+1)==1 || map(current+1)==6)
            map(current+1) = 4;
            distances(current+1)=min_dist+1;
            parent(current+1)=current;
        end
    else
        if (map(current+1-nrows)==1 || map(current+1-nrows)==6)
            map(current+1-nrows) = 4;
            distances(current+1-nrows)=min_dist+1;
            parent(current+1-nrows)=current;
        end
    end
    
    % East
    if ((current+nrows)<=nrows*ncols)
        if(map(current+nrows)==1 || map(current+nrows)==6)
            map(current+nrows) = 4;
            distances(current+nrows)=min_dist+1;
            parent(current+nrows)=current;
        end
    else 
        if(map(current+nrows-nrows*ncols)==1 || map(current+nrows-nrows*ncols)==6)
            map(current+nrows-nrows*ncols) = 4;
            distances(current+nrows-nrows*ncols)=min_dist+1;
            parent(current+nrows-nrows*ncols)=current;
        end
    end
    
    % West
    if ((current-nrows)>0) 
        if (map(current-nrows)==1 || map(current-nrows)==6)
            map(current-nrows) = 4;
            distances(current-nrows)=min_dist+1;
            parent(current-nrows)=current;
        end
    else
        if (map(current-nrows+nrows*ncols)==1 || map(current-nrows+nrows*ncols)==6)
            map(current-nrows+nrows*ncols) = 4;
            distances(current-nrows+nrows*ncols)=min_dist+1;
            parent(current-nrows+nrows*ncols)=current;
        end
    end
    
    
    % *******************************************************************
end

if (isinf(distances(dest_node)))
    route = [];
else
    route = dest_node;
    
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end
end

end

