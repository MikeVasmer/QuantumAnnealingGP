function [gs_energy] = test_lao()

    % Add eigenspectrum directory
    addpath('../eigenspectrum/');
    
    % Generate planted solution
    num_spins = 512;
    num_loops = 500;
    num_steps = 10;
    [solution, J_global, gs_energy] = loop_adaptive_optimisation(num_spins, num_loops, num_steps);
    
    % Compare gs energy with exact diag
%     h = zeros(1, num_spins);
%     Jzz  = J_global;
%     Jxx  = 0;
%     Jzzz = 0;
%     Jxxx = 0;
%     gs_energy_exact_diag = min(eig(ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx)))

end

