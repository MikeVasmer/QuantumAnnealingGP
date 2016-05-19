addpath(genpath('../../'))
clearvars

num_runs = 100;
qs = zeros([num_runs, 1]);
n_qubits = 5;
conn_density = 0.5;
h_range = [-1, 1];
J_range = [-1, 1];
timesteps = 100;
disorder = round(n_qubits / 2);
beta = 10000;


%Hparams = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);
Hparams = {0, NN_couplings(n_qubits, 1), 0, 0, 0};

spinConfig = generate_spins(n_qubits, disorder);

solution = Solver(spinConfig, Hparams, 'Metropolis');