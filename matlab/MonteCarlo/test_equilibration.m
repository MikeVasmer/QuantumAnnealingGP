clearvars
close all

%Global timesteps
timeSteps = 15000;
%Eqm Threshold
eqmThreshold = 1500;

%Hamiltonian
n_qubits = 10;
conn_density = 0.75;
h_range = [-1, 1];
J_range = [-1, 1];
disorder = round(n_qubits / 2);

Hparams = generate_random_2local_hamiltonian(n_qubits, conn_density, h_range, J_range);
%Hparams = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);
%Hparams = {0, NN_couplings(n_qubits, 1), 0, 0, 0};

%Spins
spins1 = generate_spins(n_qubits, disorder);
spins2 = generate_spins(n_qubits, disorder);

observables_Met = generateObservables(spins1, spins2, Hparams, 'Metropolis', timeSteps, eqmThreshold);
qList_Met = observables_Met{1};
magList_Met = observables_Met{2};
finalStep_Met = observables_Met{3};
%observables_HB = generateObservables(spins1, spins2, Hparams, 'Heat Bath', timeSteps, eqmThreshold);
%qList_HB = observables_HB{1};
%magList_HB = observables_HB{2};
%observables_PT = generateObservables(spins1, spins2, Hparams, 'Parallel Tempering', timeSteps, eqmThreshold);
%qList_PT = observables_PT{1};
%magList_PT = observables_PT{2};
%observables_PIQMC = generateObservables(spins1, spins2, Hparams, 'PIQMC', timeSteps, eqmThreshold);
%qList_PIQMC = observables_PIQMC{1};
%magList_PIQMC = observables_PIQMC{2};

%Plot
figure();
times_Met = linspace(1, finalStep_Met, finalStep_Met);
plot(times_Met, qList_Met)%, times, qList_HB, times, qList_PT);%, times, qList_PIQMC);
legend('Metropolis')%, 'Heat Bath', 'Parallel Tempering');%, 'PIQMC');
xlabel('Time Step');
ylabel('Order Parameter q');
title(sprintf('Order parameter equilibration for %d qubits', n_qubits))
figure();
plot(times_Met, magList_Met)%, times, magList_HB, times, magList_PT);%, times, magList_PIQMC);
legend('Metropolis')%, 'Heat Bath', 'Parallel Tempering');%, 'PIQMC');
xlabel('Time Step');
ylabel('Magnetisation');
title(sprintf('Magnetisation equilibration for %d qubits', n_qubits))




