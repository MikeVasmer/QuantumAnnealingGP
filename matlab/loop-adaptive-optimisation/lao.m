function [] = lao()

    clear global timeoutFlag

    % Add LAO algorithm directories
    addpath('./2-local/');
    addpath('./3-local/');

    % Add eigenspectrum directory
    addpath('../eigenspectrum/');

    % Locality
    locality = 2;
    % Generate planted solution
    num_spins = 10;     % Number of spins in problem
    num_loops = 10;     % Number of loops on graph
    num_steps = 200;    % Number of times a loop is replaced and optimisation step is executed
    %   Hardness Parameters
    epsilon  = 5;       % Distance from groundstate that is acceptabel as solved
    beta_h   = 10^4;    % Metropolis temperature 
    timeOut  = 10;      % seconds
    num_runs = 10;      % Times to run Metropolis to get best solve time
    hardness_params = {epsilon, beta_h, timeOut, num_runs};
    %   Transition temperature
    beta_transition = 100;

    switch locality
        case 2
            cd('./2-local/');
            % Define adjacency matrix - allowed couplings
            %    e.g. All-to-all
            adj = ones(num_spins) - eye(num_spins);

            [solution, J_global, gs_energy] = lao_2(num_spins, num_loops, num_steps, adj, hardness_params, beta_transition);
            cd('../');
        case 3
            cd('./3-local/');
            % Define adjacency matrix - allowed couplings
            %    e.g. All-to-all
            adj = all_to_all_3(num_spins);

            [solution, J_global, gs_energy] = lao_3(num_spins, num_loops, num_steps, adj, hardness_params, beta_transition);
            cd('../');
        otherwise
            disp('Can only handle 2-local and 3-local LAO algorithms!')
    end

    disp(sprintf( strcat( 'Groundstate energy: \t', num2str(gs_energy) )))

end

