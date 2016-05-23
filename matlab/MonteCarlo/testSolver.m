clearvars


n_qubits = 100;

conn_density = 0.5;
h_range = [-1, 1];
J_range = [-1, 1];
disorder = round(n_qubits / 2);



% Hparams = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);
Hparams = generate_random_2local_hamiltonian(n_qubits, conn_density, h_range, J_range);
% Hparams = {0, NN_couplings(n_qubits, 1), 0, 0, 0};
 
spinConfig = generate_spins(n_qubits, disorder);

solutionMet = Solver(spinConfig, Hparams, 'Metropolis');
solutionHB = Solver(spinConfig, Hparams, 'HeatBath');
solutionSA = Solver(spinConfig, Hparams, 'SimulatedAnnealing');

spinConfig_2 = solutionSA{2};

% solutionPT = Solver(spinConfig, Hparams, 'ParallelTempering');
solutionPIQMC = Solver(spinConfig, Hparams, 'PIQMC');

disp('Metropolis soulution is') ;
disp(solutionMet{1});
disp('Heatbath solution is')
disp(solutionHB{1});
disp('Simulated Annealing solution is') 
disp(solutionSA{1});
% disp('Parallel Tempering solution is')
% disp(solutionPT{1});
disp('PIQMC solution is') 
disp(solutionPIQMC{1});


%test = ones(1, n_qubits);
%test(3) = -1;
%test(10) = -1;

%energyChange(test,[3,10],1,1,1,Hparams{1},Hparams{2},Hparams{4})
