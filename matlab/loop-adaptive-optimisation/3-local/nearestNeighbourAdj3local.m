function [ adj_mat ] = nearestNeighbourAdj3local( m, n )
%NEARESTNEIGHBOURADJ3LOCAL Creates the adjacency matrix for a 
%mxn grid of qubits with 3-local nearest
%neighbour interactions, in a triangular tesselation.

num_qubits = m * n;
adj_mat = zeros(num_qubits, num_qubits, num_qubits);

for i = 1:num_qubits

    % Find pairs of qubits which, along with i, constitute a valid plaquette.
    pair1 = [i-1, i-n];
    pair2 = [i-n, i-n+1];
    pair3 = [i-1+n, i+n];
    pair4 = [i+1, i+n];
    pair5 = [i+n-1, i+n];
    pair6 = [i+n-1, i-1];
    
    pairs = {pair1, pair2, pair3, pair4, pair5, pair6};
    good_pairs = {};
    
    for j = 1:length(pairs)
    
        pair = pairs{j};
        conditions = [1 <= pair(1); ...
                      pair(1) <= num_qubits; ...
                      1 <= pair(2); ...
                      pair(2) <= num_qubits];
                  
        if all(conditions)
        
            good_pairs{end+1} = pair;
        
        end
        
    end
    
    % Add to adjacency matrix
    for j = 1:length(good_pairs)
        
        pair = good_pairs{j};
        adj_mat(i, pair(1), pair(2)) = 1;
        
    end
    
end

% Make invariant under perms

adj_mat = symmetrize_3local_couplings(adj_mat);

end

