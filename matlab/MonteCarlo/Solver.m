function [ solution ] = Solver( spinConfig, Hparams, SolverType )
%SOLVER Solves some Hamiltonian given an initial input spin configuration,
%Hamiltonian parameters and solution algorithm.

%% DEFAULT PARAMETERS

% Metropolis
beta_M = 10000;
timesteps_M = 1000;
num_flips_M = 1;
Gamma_M = 1;

% Heat Bath
beta_HB = 10000;
timesteps_HB = 1000;
Gamma_HB = 1;

%Simulated Annealing
initialTemp = 1e30;
spinStepSize = 1;
iterations = 1000;
scheduleType = 'exponential';

% ParallelTempering
betas_PT = [1,10, 1000, 10000, 100000];
totalRuns_PT = 100;
backendMonty_PT = 'Metropolis';
sweepsMonty_PT = 1;
Gamma_PT = 1;
num_flips_PT = 1;

%% SOLVE

switch SolverType
    case 'Metropolis'
        solution_config = Metropolis(spinConfig, Hparams, beta_M, timesteps_M, num_flips_M, Gamma_M);
        solution_energy = Conf_energy(solution_config, Hparams);
        solution = {solution_energy, solution_config};
    case 'HeatBath'
        solution_config = HeatBath(spinConfig, Hparams, beta_HB, timesteps_HB, Gamma_HB);
        solution_energy = Conf_energy(solution_config, Hparams);
        solution = {solution_energy, solution_config};
    case 'SimulatedAnnealing'
        solution = simulatedAnnealing(Hparams, spinConfig, initialTemp,...
            spinStepSize, iterations, scheduleType);
    case 'ParallelTempering'
        solution = ParallelTempering(spinConfig, Hparams, betas_PT, totalRuns_PT, ...
                                        backendMonty_PT, sweepsMonty_PT, Gamma_PT, num_flips_PT);
    otherwise
        disp('Enter valid Monte Carlo Algorithm')


end

