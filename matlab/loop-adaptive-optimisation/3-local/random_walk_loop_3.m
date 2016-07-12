function [ out ] = random_walk_loop_3( adj )
    % Given an adjacency matrix - defining the tri-coupled nodes
    % Perform a random walk until one creates a loop
    % Cut the tail and return the loop sequence

    % Number of nodes
    num_nodes = length(adj);
    
    % Until loop is found
    loop_found = false;
    while(~loop_found)
        
        % Pick random starting tri-coupling (tri)
        node_perm = randperm(num_nodes);
        adj_x = node_perm(1);
        [adj_y,adj_z] = find(squeeze(adj(adj_x,:,:)));
        rand_ind = randi(length(adj_y));
        adj_y = adj_y(rand_ind);
        adj_z = adj_z(rand_ind);
        
        % Set the starting tri of the loop
        loop_start = sort([adj_x,adj_y,adj_z]);
        % Initialise loop sequence starting at loop_start
        loop_seq = {loop_start};
        % Initialise previous tri-coupling to 0's array
        prev_tri = [0,0,0];
        
        % Until loop is found
        while(~loop_found)            
            % Find adjacent tri-couplings (2D array)
            current_tri = loop_seq{end};
            %   Pick two random dimensions of current tri
            chosen_dims = randperm(3);
            %   Select random column with two common nodes
            selected_col = adj(:,current_tri(chosen_dims(1)),current_tri(chosen_dims(2)));
            %   Find all 1's in selected column
            adj_tris = find(selected_col);
            % Remove previous tri-coupling from adjacent tri-couplings
            temp_adj_tris = [];
            for i = 1:length(adj_tris(:,1))
                % Index to co-ord
                potential_tri = [ current_tri(chosen_dims(1)), current_tri(chosen_dims(2)), adj_tris(i) ];
                % Is this equal to the previous node (modulo some permutations)
                if ~isequal( sort(potential_tri), sort(prev_tri) ) && ~isequal( sort(potential_tri), sort(current_tri) )
                    temp_adj_tris = [temp_adj_tris; potential_tri];
                end
            end
            % Update adjacent tris to exclude previous tri, and be in
            % co-ordinate form
            adj_tris = temp_adj_tris;
            
            % If no valid adjacent tris, then abort and start over
            if isempty(adj_tris)
                break; 
            end
            
            % Pick random adjacent tri
            next_tri = adj_tris(randi(length(adj_tris(:,1))),:);
            % Set previous tri
            prev_tri = loop_seq{end};
            % Add to loop sequence
            loop_seq = [loop_seq, sort(next_tri)];
            
            % If loop_seq{end} exists in loop_sequence, then loop found
            for i = 1: length(loop_seq)-1
                if isequal(loop_seq{i}, loop_seq{end})
                    % Set loop_found flag to true
                    loop_found = true;

                    % Cut tail off sequence
                    loop_seq = loop_seq(i:end);
                    break;
                end
            end
        end 
    end    
    
    % Return loop sequence
    out = loop_seq;
end

