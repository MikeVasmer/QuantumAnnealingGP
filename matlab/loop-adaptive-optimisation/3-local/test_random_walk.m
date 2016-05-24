addpath('../../MonteCarlo/')

num_nodes = 5;
adj = zeros(num_nodes,num_nodes,num_nodes);

for i = 1:num_nodes
    for j = i+1:num_nodes
        for k = j+1:num_nodes
            adj(i,j,k) = 1;
        end
    end
end

adj = symmetrize_3local_couplings(adj);

random_walk_loop_3(adj)

