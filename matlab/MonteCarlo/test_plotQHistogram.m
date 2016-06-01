clearvars
close all

n_qubits = 10;

conn_density = 1;
h_range = [-1, 1];
J_range = [-1, 1];
disorder = round(n_qubits / 2);

num_runs = 25;
monty_timeSteps = 5000;

%Hparams = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);
Hparams = generate_random_2local_hamiltonian(n_qubits, conn_density, h_range, J_range);
%Hparams = {0, NN_couplings(n_qubits, 1), 0, 0, 0};

hardness = plotQHistogram('Metropolis', Hparams, num_runs, n_qubits, disorder, 1, monty_timeSteps);