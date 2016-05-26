addpath(genpath('../../'))   

% Locality
locality = 3;
% LAO parameters


num_spins = [20,30,40];

num_spins = [40,50,60];

num_loops = 2*num_spins;
num_steps = 200;
% Hardness parameters
epsilon = round(2*sqrt(num_spins));
beta_h = 10^4;
timeOut = 300;
num_runs = 5;
% Transition temperature for optimisation stage
beta_transition = 100;

% Loop for each element in num_spins
for i = 1:length(num_spins)
    % Loop such that we run each num_spins 10 times
    for j = 1:10

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
            num_spins(i), ...    % Number of spins in problem
            num_loops(i), ...     % Number of loops on graph
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
        lao(paramsMap);
    end
end


