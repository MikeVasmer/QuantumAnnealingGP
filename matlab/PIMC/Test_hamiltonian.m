
n_qubits = 100;
conn_density = 0.8;
h_range = [-1, 1];
J_range = [-1, 1];
disorder = round(n_qubits / 2);

% Hparams = generate_random_2local_hamiltonian(n_qubits, conn_density, h_range, J_range);

Hparams = {0, NN_couplings(n_qubits, 1), 0, 0, 0};

save('Hparams_test.mat', 'Hparams', 'n_qubits');