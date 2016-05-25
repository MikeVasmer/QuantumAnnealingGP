addpath(genpath('../../'))   

% Locality
locality = 2;
% LAO parameters
num_spins = 20;
num_loops = 20;
num_steps = 200;
% Hardness parameters
epsilon = 10;
beta_h = 10^4;
timeOut = 30;
num_runs = 5;
% Transition temperature
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

paramsMap = containers.Map(keys, values);
lao(paramsMap);
