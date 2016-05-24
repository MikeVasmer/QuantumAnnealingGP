function [] = test_lao_3()

    % Add eigenspectrum directory
    addpath('../../eigenspectrum/');
    
    % Generate planted solution
    num_spins = 11;
    num_loops = 10;
    num_steps = 5;
    [solution, J_global, gs_energy] = lao_3(num_spins, num_loops, num_steps);
    
    gs_energy
    
    % Compare gs energy with exact diag
    h    = 0;
    Jzz  = 0;
    Jxx  = 0;
    Jzzz = J_global;
    Jxxx = 0;
    gs_energy_exact_diag = min(eig(ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx)))

end

