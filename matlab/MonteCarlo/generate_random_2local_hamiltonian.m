function [ Hparams ] = generate_random_2local_hamiltonian( n_qubits, conn_density, h_range, J_range )
%GENERATE_RANDOM_HAMILTONIAN Generates a random 2 local Hamiltonian

%% Generate random Hamiltonian
% Array of h coef for local fields

h = random_coef([n_qubits], 1, h_range, 0, conn_density);

Jzz  = random_coef( [n_qubits,n_qubits],  1, J_range, 0, conn_density );
Jzz = symmetrize_2local_couplings(Jzz);

Jxx  = 0; % Couplings turned off
Jxxx = 0; % Couplings turned off
Jzzz = 0; % Couplings turned off

Hparams = {h, Jzz, Jxx, Jzzz, Jxxx};

end

