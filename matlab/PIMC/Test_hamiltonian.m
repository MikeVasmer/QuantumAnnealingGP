
n_qubits = 30;
conn_density = 0.8;
h_range = [-1, 1];
J_range = [-1, 1];
disorder = round(n_qubits / 2);

Hparams = generate_random_2local_hamiltonian(n_qubits, conn_density, h_range, J_range);

save('Hparams_test.mat', 'Hparams');