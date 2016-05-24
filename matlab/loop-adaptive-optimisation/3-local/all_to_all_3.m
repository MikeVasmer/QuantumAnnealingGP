function [ out ] = all_to_all_3(num_spins)

    % Add path for symmetrize_3local_couplings function
    addpath('../../MonteCarlo/')
    
    % Define adjacency matrix - allowed couplings
    %    e.g. All-to-all
    adj = zeros(num_spins,num_spins,num_spins);
    for i = 1:num_spins
        for j = i+1:num_spins
            for k = j+1:num_spins
                adj(i,j,k) = 1;
            end
        end
    end
    
    out = symmetrize_3local_couplings(adj);
end

