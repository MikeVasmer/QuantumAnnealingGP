function [J_local] = local_hamiltonian_3( solution, loop )
    % Given a loop (sequence of node triples), and solution (and spin configuration)
    % Calculate couplings, J that minimise the loop energy

    % Number of spins
    num_spins = length(solution);

    % Initialise local couplings matrix with zeros
    J_local = zeros(num_spins, num_spins, num_spins);
    
    % Loop through triplets of nodes in loop
    for i = 1:length(loop)
        % Get node triplet
        triplet = sort(loop{i});
        % Set coupling to J = -s_1 s_2
        J_local(triplet(1), triplet(2), triplet(3)) = ...
            -solution(triplet(1)) * solution(triplet(2)) * solution(triplet(3));
    end
    
    % Flip one random coupling
    coupling_indicies = find(J_local);
    random_coupling = coupling_indicies(randi(length(coupling_indicies)));
    J_local(random_coupling) = -J_local(random_coupling);
    
end