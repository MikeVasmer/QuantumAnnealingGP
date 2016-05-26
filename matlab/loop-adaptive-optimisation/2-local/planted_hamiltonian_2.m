function [J_global, gs_energy] = planted_hamiltonian_2( solution, loops )

    % Add PIMC/ to path for Conf_energy function
    %addpath('../../PIMC/');

    % Number of spins
    num_spins = length(solution);
    % Number of loops
    num_loops = length(loops(:,1));

    % Initialise global couplings matrix with zeros
    J_global = zeros(num_spins, num_spins);
    
    % Calculate global couplings
    for i = 1:num_loops
        % Calculate local Hamiltonian couplings
        J_local = local_hamiltonian_2(solution, loops(i,:));
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
    J_global = J_global + J_global';
    
    % Calculate groundstate energy
    spin_config = solution;
    h = 0;
    Jzz  = J_global;
    Jxx  = 0;
    Jzzz = 0;
    Jxxx = 0;
    hParams = {h, Jzz, Jxx, Jzzz, Jxxx};
    
    gs_energy = Conf_energy( spin_config, hParams );

end

