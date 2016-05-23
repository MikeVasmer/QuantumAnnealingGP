function [ out ] = random_walk_loop_2( adj )
    % Given an adjacency matrix - defining the coupled nodes
    % Perform a random walk until on creates a loop
    % Cut the tail and return the loop sequence

    % Number of nodes
    num_nodes = length(adj);
    
    % Until loop is found
    loop_found = false;
    while(~loop_found)
        
        % Pick random starting node
        loop_start = randi(num_nodes);
        % Initialise loop sequence starting at loop_start
        loop_seq = [loop_start];
        % Initialise previous node to 0
        prev_node = 0;
        
        % Until loop is found
        while(~loop_found)
            % Random walk can not return to immediate node
            % If no other couplings are avaiable - abort and start over
            
            % Find adjacent nodes
            adj_nodes = find(adj(:,loop_seq(end)));
            % Remove previous node from adjacent nodes
            adj_nodes = adj_nodes(find(adj_nodes~=prev_node));
            
            % If no valid adjacent nodes, then abort and start over
            if isempty(adj_nodes)
                break; 
            end
            
            % Pick random adjacent node
            next_node = adj_nodes(randi(length(adj_nodes)));
            % Set previous node
            prev_node = loop_seq(end);
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

