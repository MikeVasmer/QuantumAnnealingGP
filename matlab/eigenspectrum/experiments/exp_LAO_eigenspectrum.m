function [out] = exp_LAO_eigenspectrum(num_qubits)

% Generate random LAO Hamiltonian
num_loops       = 2*num_qubits;
adj             = ones(num_qubits,num_qubits) - eye(num_qubits,num_qubits);
epsilon         = 0;
beta_h          = 10^4;
timeOut         = 3;
num_runs        = 5;
hardness_params = {epsilon, beta_h, timeOut, num_runs};

% Run LAO 
[solution, J_global, gs_energy] = lao_no_optimisation_2(num_qubits, num_loops, adj, hardness_params);

% Init h coef
h = 0;
% Init J coef for Z-Z, X-X, Z-Z-Z and X-X-X couplings
Jzz  = J_global;
Jxx  = 0; % Couplings turned off
Jzzz = 0; % Couplings turned off
Jxxx = 0; % Couplings turned off
% Calculate groundstate
out = min(eig(ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx))); 
            
end