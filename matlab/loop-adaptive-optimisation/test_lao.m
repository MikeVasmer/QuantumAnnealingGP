function [gs_energy] = test_lao()

    % Add eigenspectrum directory
    addpath('../eigenspectrum/');
    
    % Generate planted solution
    num_spins = 512;
    num_loops = 500;
    [solution, J_global, gs_energy] = loop_adaptive_optimisation(num_spins,num_loops);
    
    % Compare gs energy with exact diag
    % Array of h coef for local fields
    h = zeros(1, num_spins);
    % Matrix of J coef for Z-Z, X-X, Z-Z-Z and X-X-X couplings
    Jzz  = J_global;
    Jxx  = 0; % Couplings turned off
    Jzzz = 0; % Couplings turned off
    Jxxx = 0; % Couplings turned off

    %gs_energy_exact_diag = min(eig(ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx)))

end

