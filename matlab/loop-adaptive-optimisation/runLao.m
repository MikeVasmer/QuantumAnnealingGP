addpath(genpath('../../'))   

%% SET UP PARAMETERS

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

%% RUN DA TING
    
num_qubits_array = [10:10:100, 125:25:1000];
num_loops_array = [10:10:100, 125:25:1000];
num_optimisation_steps_array = [200, 400, 1000, 2000];
timeouts_array = [30, 60, 120, 240];

for num_qubits = num_qubits_array
    for num_loops = num_loops_array
        for num_optimisation_steps = num_optimisation_steps_array
            for timeout = timeouts_array
                
                values = {...
                    2, ...     % locality
                    num_qubits, ...    % Number of spins in problem
                    num_loops, ...     % Number of loops on graph
                    num_optimisation_steps, ...    % Number of times a loop is replaced and optimisation step is executed
                    5, ...      % Distance from groundstate that is acceptable as solved
                    10^4, ...    % Metropolis temperature 
                    timeout, ...      % Timeout in seconds
                    10, ...     % Times to run Metropolis to get best solve time
                    100, ... % Transition temperature
                    };

                paramsMap = containers.Map(keys, values);
                lao(paramsMap);
                
            end
        end
    end
end




