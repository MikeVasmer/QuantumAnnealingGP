clearvars
close all

n_qubits = 20;
conn_density = 0.5;
h_range = [-1, 1];
J_range = [-1, 1];
disorder = round(n_qubits / 2);
num_runs = 100;

Hparams = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);
%Hparams = {0, NN_couplings(n_qubits, 1), 0, 0, 0};

%plotQHistogram('Metropolis', Hparams, num_runs, n_qubits, disorder);
plotQHistogram('Heat Bath', Hparams, num_runs, n_qubits, disorder);
%plotQHistogram('Parallel Tempering', Hparams, num_runs, n_qubits, disorder);
plotQHistogram('Simulated Annealing', Hparams, num_runs, n_qubits, disorder);