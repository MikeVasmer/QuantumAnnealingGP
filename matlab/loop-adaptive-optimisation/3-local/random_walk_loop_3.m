function [ out ] = random_walk_loop_3( adj )
    % Given an adjacency matrix - defining the tri-coupled nodes
    % Perform a random walk until on creates a loop
    % Cut the tail and return the loop sequence

    % Number of nodes
    num_nodes = length(adj);
    
    % Until loop is found
    loop_found = false;
    while(~loop_found)
        
        % Pick random starting tri-coupling (tri)
        node_perm = randperm(num_nodes);
        loop_start = sort(node_perm(1:3));
        % Initialise loop sequence starting at loop_start
        loop_seq = {loop_start};
        % Initialise previous tri-coupling to 0's array
        prev_tri = [0,0,0];
        
        % Until loop is found
        while(~loop_found)            
            % Find adjacent tri-couplings (2D array)
            end_tri = loop_seq{end};
            a= adj(:,:,end_tri(1));
            adj_tris = find(adj(:,:,end_tri(1)));
            % Remove previous tri-coupling from adjacent tri-couplings
            temp_adj_tris = [];
            for i = 1:length(adj_tris)
                % Index to co-ord
                coord = [ end_tri(1), floor((adj_tris(i)-1)/num_nodes)+1, mod((adj_tris(i)-1),num_nodes)+1 ];
                if ~isequal( sort(coord), sort(prev_tri) )
                    temp_adj_tris = [temp_adj_tris, adj_tris(i)];
                end
            end
            adj_tris = temp_adj_tris;
            
            % If no valid adjacent nodes, then abort and start over
            if isempty(adj_tris)
                break; 
            end
            
            % Pick random adjacent node
            next_node = adj_tris(randi(length(adj_tris)));
            % Set previous node
            prev_tri = loop_seq(end);
            % Add to loop sequence
            loop_seq = [loop_seq, next_node];
            
            % If loop_seq[end] exists in loop_sequence, then loop found
            if ~isempty(find(loop_seq(1:end-1)==loop_seq(end)))
                % Set loop_found flag to true
                loop_found = true;
                
                % Cut tail off sequence
                start_index = find(loop_seq(1:end-1)==loop_seq(end));
                loop_seq = loop_seq(start_index:end);
            end
        end 
    end
    
    % Return loop sequence
    out = loop_seq;
end

