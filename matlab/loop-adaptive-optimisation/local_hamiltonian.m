function [J_local] = local_hamiltonian( solution, loop )

    % Number of spins
    num_spins = length(solution);

    % Initialise local couplings matrix with zeros
    J_local = zeros(num_spins, num_spins);
    
    % Remove loop padding
    loop = loop(find(loop~=0));
    
    % Loop through pairs of nodes in loop
    for i = 1:(length(loop)-1)
        % Get node pair
        pair = [loop(i), loop(i+1)];
        % Set coupling to J = -s_1 s_2
        J_local(min(pair), max(pair)) = -solution(pair(1)) * solution(pair(2));
    end
    
end

