clearvars
close all


n_qubits = 64;

conn_density = 1;
h_range = [-1, 1];
J_range = [-1, 1];
disorder = round(n_qubits / 2);

num_runs = 250;


Hparams = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);
%Hparams = generate_random_2local_hamiltonian(n_qubits, conn_density, h_range, J_range);
%Hparams = {0, NN_couplings(n_qubits, 1), 0, 0, 0};

plotQHistogram('Metropolis', Hparams, num_runs, n_qubits, disorder);
%plotQHistogram('Heat Bath', Hparams, num_runs, n_qubits, disorder);
%plotQHistogram('Parallel Tempering', Hparams, num_runs, n_qubits, disorder);
plotQHistogram('Simulated Annealing', Hparams, num_runs, n_qubits, disorder);
%plotQHistogram('PIQMC', Hparams, num_runs, n_qubits, disorder);
kurtosis_Met = plotQHistogram('Metropolis', Hparams, num_runs, n_qubits, disorder);
%kurtosis_HB = plotQHistogram('Heat Bath', Hparams, num_runs, n_qubits, disorder);
%kurtosis_PT = plotQHistogram('Parallel Tempering', Hparams, num_runs, n_qubits, disorder);
%kurtosis_SA = plotQHistogram('Simulated Annealing', Hparams, num_runs, n_qubits, disorder);
%kurtosis_PIQMC = plotQHistogram('PIQMC', Hparams, num_runs, n_qubits, disorder);
