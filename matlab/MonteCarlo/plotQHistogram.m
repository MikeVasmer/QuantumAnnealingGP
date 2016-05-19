function plotQHistogram(algorithm, Hparams, num_runs, n_qubits, disorder)

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
initialTemp_SA = 1e30;
spinStepSize_SA = 1;
iterations_SA = 1000;
scheduleType_SA = 'exponential';

% ParallelTempering
betas_PT = choose_betas_PT(1e5, 1e20, 10);
totalRuns_PT = 1000;
backendMonty_PT = 'Metropolis';
sweepsMonty_PT = 1;
Gamma_PT = 1;
num_flips_PT = 1;

% Path Integral Quantum Monte Carlo
monte_steps = 100;
trotter_slices = 20;
G_start = 1;
Temperature = 0.1;
step_flips = 1;

qs = zeros([num_runs, 1]);

for run=1:num_runs
    spins1 = generate_spins(n_qubits, disorder);
    spins2 = generate_spins(n_qubits, disorder);
    switch algorithm
        case 'Metropolis'
            spins1 = Metropolis(spins1, Hparams, beta_M, timesteps_M, num_flips_M, Gamma_M);
            spins2 = Metropolis(spins2, Hparams, beta_M, timesteps_M, num_flips_M, Gamma_M);
        case 'Heat Bath'
            spins1 = HeatBath(spins1, Hparams, beta_HB, timesteps_HB, Gamma_HB);
            spins2 = HeatBath(spins2, Hparams, beta_HB, timesteps_HB, Gamma_HB);
        case 'Parallel Tempering'
            solution = ParallelTempering(spins1, Hparams, betas_PT, totalRuns_PT,...
                            backendMonty_PT, sweepsMonty_PT, Gamma_PT, num_flips_PT);
            spins1  = solution{2};
            solution = ParallelTempering(spins2, Hparams, betas_PT, totalRuns_PT,...
                            backendMonty_PT, sweepsMonty_PT, Gamma_PT, num_flips_PT);
            spins2  = solution{2};
        case 'Simulated Annealing'
            solution = simulatedAnnealing(Hparams, spins1, initialTemp_SA,...
                         spinStepSize_SA, iterations_SA, scheduleType_SA);
            spins1 = solution{2};
            solution = simulatedAnnealing(Hparams, spins2, initialTemp_SA,...
                         spinStepSize_SA, iterations_SA, scheduleType_SA);
            spins2 = solution{2};
        case 'PIQMC'
            solution = piqmc(spins1, Hparams, monte_steps, trotter_slices, G_start, Temperature, step_flips);
            spins1 = solution{2};
            solution = piqmc(spins2, Hparams, monte_steps, trotter_slices, G_start, Temperature, step_flips);
            spins2 = solution{2};
        otherwise 
            disp('Invalid algorithm name');
    end
    q = dot(spins1,spins2)/n_qubits;
    qs(run) = q;
    %disp(run);
end

%disp(qs);
figure();
edges = linspace(-1, 1, 50);
histogram(qs, edges, 'Normalization', 'probability');
xlabel('q')
ylabel('P(q)')