function [observables] = generateObservables(spins1, spins2, Hparams, algorithm, timeSteps, eqmThreshold)

% Metropolis Params
beta_M = 1e20;
timesteps_M = 1;
num_flips_M = 1;
Gamma_M = 1;

% ParallelTempering Params
betas_PT = choose_betas_PT(1e5, 1e20, 10);
totalRuns_PT = 1;
backendMonty_PT = 'Metropolis';
sweepsMonty_PT = 1;
Gamma_PT = 1;
num_flips_PT = 1;

% Heat Bath
beta_HB = 10000;
timesteps_HB = 1;
Gamma_HB = 1;

% Path Integral Quantum Monte Carlo
monte_steps = 1;
trotter_slices = 1;
G_start = 2;
Temperature = 0.01;
step_flips = 1;

n_qubits = length(spins1);
qList = ones(timeSteps, 1);
magList = ones(timeSteps, 1);

equalCount = 0;
breakTimeStep = timeSteps;

tic;
for timeStep=1:timeSteps
    
    switch algorithm
        case 'Metropolis'
            spins1 = Metropolis(spins1, Hparams, beta_M, timesteps_M, num_flips_M, Gamma_M);
            spins2 = Metropolis(spins2, Hparams, beta_M, timesteps_M, num_flips_M, Gamma_M);
        case 'Parallel Tempering'
            solution1_PT = ParallelTempering(spins1, Hparams, betas_PT, totalRuns_PT, ...
                backendMonty_PT, sweepsMonty_PT, Gamma_PT, num_flips_PT);
            spins1 = solution1_PT{2};
            solution2_PT = ParallelTempering(spins2, Hparams, betas_PT, totalRuns_PT, ...
                backendMonty_PT, sweepsMonty_PT, Gamma_PT, num_flips_PT);
            spins2 = solution2_PT{2};
        case 'Heat Bath'
            spins1 = HeatBath(spins1, Hparams, beta_HB, timesteps_HB, Gamma_HB);
            spins2 = HeatBath(spins2, Hparams, beta_HB, timesteps_HB, Gamma_HB);
        case 'PIQMC'
            solution1_PIQMC = piqmc(spins1, Hparams, monte_steps, trotter_slices,...
                G_start, Temperature, step_flips);
            spins1 = solution1_PIQMC{2};
            solution2_PIQMC = piqmc(spins2, Hparams, monte_steps, trotter_slices,...
                G_start, Temperature, step_flips);
            spins2 = solution2_PIQMC{2};
        otherwise
            disp('Enter valid MC');
    end
            
    magList(timeStep) = sum(spins1)/n_qubits;
    qList(timeStep) = dot(spins1, spins2)/n_qubits;
    
    if timeStep ~= 1
        if magList(timeStep) == magList(timeStep-1) && qList(timeStep) == qList(timeStep-1) 
            equalCount = equalCount + 1;
        else
           equalCount = 0; 
        end
    end
    
    if toc > 1
       fprintf('%d:%d\n',timeStep,timeSteps);
       tic;
    end
    
    if equalCount >= eqmThreshold
        breakTimeStep = timeStep;
        break;
    end
      
end
qList = qList(1:breakTimeStep);
magList = magList(1:breakTimeStep);
observables = {qList, magList, breakTimeStep};
end