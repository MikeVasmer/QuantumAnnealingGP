addpath(genpath('../'))   

% Locality
locality = 3;
% LAO parameters
num_spins = 81;
num_loops = 2*num_spins;
num_steps = 100;
% Hardness parameters
epsilon = round(2*sqrt(num_spins));
beta_h = 10^4;
timeOut = 10;
num_runs = 5;
% Transition temperature for optimisation stage
beta_transition = 100;

keys = {...
    'locality', ...     % locality
    'num_spins', ...     % Number of spins in problem
    'num_loops', ...     % Number of loops on graph
    'num_steps', ...   % Number of times a loop is replaced and optimisation step is executed
    'epsilon', ...      % Distance from groundstate that is acceptable as solved
    'beta_h', ...    % Metropolis temperature 
    'timeOut', ...     % seconds
    'num_runs', ...      % Times to run Metropolis to get best solve time
    'beta_transition', ... % Transition temperature
};
                
values = {...
    locality, ...     % locality
    num_spins, ...    % Number of spins in problem
    num_loops, ...     % Number of loops on graph
    num_steps, ...    % Number of times a loop is replaced and optimisation step is executed
    epsilon, ...      % Distance from groundstate that is acceptable as solved
    beta_h, ...    % Metropolis temperature 
    timeOut, ...      % Timeout in seconds
    num_runs, ...     % Times to run Metropolis to get best solve time
    beta_transition, ... % Transition temperature
};

% Contain variables into a Map structure
paramsMap = containers.Map(keys, values);

% Run LAO algorithm
[solution, J_global, gs_energy] = lao(paramsMap)
