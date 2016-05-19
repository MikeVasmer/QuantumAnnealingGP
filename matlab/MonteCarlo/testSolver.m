clearvars

num_runs = 100;
qs = zeros([num_runs, 1]);
n_qubits = 30;
conn_density = 0.5;
h_range = [-1, 1];
J_range = [-1, 1];
timesteps = 100;
disorder = round(n_qubits / 2);
beta = 10000;

%Hparams = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);
Hparams = {0, NN_couplings(n_qubits, 1), 0, 0, 0};

spinConfig = generate_spins(n_qubits, disorder);

solutionMet = Solver(spinConfig, Hparams, 'Metropolis');
%solutionHB = Solver(spinConfig, Hparams, 'HeatBath');
solutionSA = Solver(spinConfig, Hparams, 'SimulatedAnnealing');
%solutionPT = Solver(spinConfig, Hparams, 'ParallelTempering');

disp(solutionMet{1});
%disp(solutionHB{1});
disp(solutionSA{1});
%disp(solutionPT{1});


