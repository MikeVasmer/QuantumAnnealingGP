addpath(genpath('../../'))   

% Experiment number
%  1: 2-local, 100 steps, 3s  timeout, 40 LAO beta
%  2: 3-local, 50  steps, 10s timeout, 20 LAO beta
experiment_number = 1;

% Locality
locality = [2,3];
% LAO parameters
num_spins = 80;
num_loops = 2*num_spins;
num_steps = [30,50];
% Hardness parameters
epsilon = round(2*sqrt(num_spins));
beta_h = 10^5;
timeOut = [1, 20];
num_runs = 5;
% Transition temperature for optimisation stage
beta_transition = [40,20];
% Number of times to repeat LAO
num_LAO_loops = 1000;

% Max number of problems
max_problems = 300;

% Loop for each element in num_spins
for i = 1:length(num_spins)
    % Loop such that we run each num_spins 10 times
    for j = 1:num_LAO_loops

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
            locality(experiment_number), ...     % locality
            num_spins(i), ...    % Number of spins in problem
            num_loops(i), ...     % Number of loops on graph
            num_steps(experiment_number), ...    % Number of times a loop is replaced and optimisation step is executed
            epsilon, ...      % Distance from groundstate that is acceptable as solved
            beta_h, ...    % Metropolis temperature 
            timeOut(experiment_number), ...      % Timeout in seconds
            num_runs, ...     % Times to run Metropolis to get best solve time
            beta_transition(experiment_number), ... % Transition temperature
        };

        % Contain variables into a Map structure
        paramsMap = containers.Map(keys, values);

        % Run LAO algorithm
        lao(paramsMap);
        
        % break out if number of files is greater than x
        D = dir(['files\2Local\Chimera\80-qubits', '\*.mat']);
        if length(D(not([D.isdir]))) >= max_problems
            break;
        end
    end
end
