function [] = test_lao_2()

    % Add eigenspectrum directory
    addpath('../../eigenspectrum/');
    
    % Generate planted solution
    num_spins = 10;
    num_loops = 10;
    num_steps = 10;
    [solution, J_global, gs_energy] = lao_2(num_spins, num_loops, num_steps);
    
    disp(sprintf( strcat( 'Groundstate energy: \t', num2str(gs_energy) )))
    
    % Compare gs energy with exact diag
%     h = zeros(1, num_spins);
%     Jzz  = J_global;
%     Jxx  = 0;
%     Jzzz = 0;
%     Jxxx = 0;
%     gs_energy_exact_diag = min(eig(ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx)))

end

