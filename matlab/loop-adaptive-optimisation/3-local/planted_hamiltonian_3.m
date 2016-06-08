function [J_global, gs_energy] = planted_hamiltonian_3( solution, loops )
    % Given loops (sequences of node triples), and solutions (and spin configurations)
    % Calculate global couplings, J_global, from local couplings J that
    % minimise the loop energies

    % Number of spins
    num_spins = length(solution);
    % Number of loops
    num_loops = length(loops);

    % Initialise global couplings matrix with zeros
    J_global = zeros(num_spins, num_spins, num_spins);
    
    % Calculate global couplings
    for i = 1:num_loops
        % Calculate local Hamiltonian couplings
        J_local = local_hamiltonian_3(solution, loops{i});
        % Update global, by adding them together
        J_global = J_global + J_local;
    end
    
    % Normalise final J_global
    for j = 1:numel(J_global)
        if J_global(j) > 0
            J_global(j) = 1;
        elseif J_global(j) < 0
            J_global(j) = -1;
        end
    end
    
    % Symmetrise J_global
    J_global = symmetrize3local(J_global);
    
    % Calculate groundstate energy
    spin_config = solution;
    h = 0;
    Jzz  = 0;
    Jxx  = 0;
    Jzzz = J_global;
    Jxxx = 0;
    hParams = {h, Jzz, Jxx, Jzzz, Jxxx};
    
    gs_energy = Conf_energy( spin_config, hParams );

end
