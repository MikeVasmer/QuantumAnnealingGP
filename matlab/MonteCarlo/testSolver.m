clearvars

n_qubits = 20;
conn_density = 0.1;
h_range = [0, 0];
J_range = [-1, 1];
disorder = round(n_qubits / 2);
beta = 10000;





%Hparams = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);
%Hparams = generate_random_2local_hamiltonian(n_qubits, conn_density, h_range, J_range);
Hparams = {[], NN_couplings(n_qubits, 1), [], [], []};

spinConfig = generate_spins(n_qubits, disorder);

%solutionMet = Solver(spinConfig, Hparams, 'Metropolis');
%solutionHB = Solver(spinConfig, Hparams, 'HeatBath');
solutionSA = Solver(spinConfig, Hparams, 'SimulatedAnnealing');
%solutionPT = Solver(spinConfig, Hparams, 'ParallelTempering');
%solutionPIQMC = Solver(spinConfig, Hparams, 'PIQMC');
%solutionPIQMC = piqmc(spinConfig, Hparams, 100, 20, 1, 0.5, 1)

%disp(solutionMet{1});
%disp(solutionHB{1});
disp(solutionSA{1});
%disp(solutionPT{1});
% disp(solutionPIQMC{1});



