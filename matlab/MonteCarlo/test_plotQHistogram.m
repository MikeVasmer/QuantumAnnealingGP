clearvars
close all

n_qubits = 12;

conn_density = 1;
h_range = [-1, 1];
J_range = [-1, 1];
disorder = round(n_qubits / 2);

num_runs = 250;
monty_timeSteps = 1000;

%Hparams = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);
Hparams = generate_random_2local_hamiltonian(n_qubits, conn_density, h_range, J_range);
%Hparams = {0, NN_couplings(n_qubits, 1), 0, 0, 0};

kurtosis_Met = plotQHistogram('Metropolis', Hparams, num_runs, n_qubits, disorder, 0, monty_timeSteps);
%kurtosis_HB = plotQHistogram('Heat Bath', Hparams, num_runs, n_qubits, disorder, 1, monty_timeSteps);
%kurtosis_PT = plotQHistogram('Parallel Tempering', Hparams, num_runs, n_qubits, disorder, 1, monty_timeSteps);
%kurtosis_SA = plotQHistogram('Simulated Annealing', Hparams, num_runs, n_qubits, disorder, 1, monty_timeSteps);
%kurtosis_PIQMC = plotQHistogram('PIQMC', Hparams, num_runs, n_qubits, disorder, 1, monty_timeSteps);
