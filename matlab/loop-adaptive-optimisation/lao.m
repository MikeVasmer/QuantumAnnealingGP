function [] = lao(paramsMap)
    % Clear previous timeoutFlag
    %clear global timeoutFlag

    % Locality
    locality = paramsMap('locality');
    % Generate planted solution
    num_spins = paramsMap('num_spins');     % Number of spins in problem
    num_loops = paramsMap('num_loops');     % Number of loops on graph
    num_steps = paramsMap('num_steps');    % Number of times a loop is replaced and optimisation step is executed
    %   Hardness Parameters
    epsilon  = paramsMap('epsilon');       % Distance from groundstate that is acceptabel as solved
    beta_h   = paramsMap('beta_h');    % Metropolis temperature 
    timeOut  = paramsMap('timeOut');      % seconds
    num_runs = paramsMap('num_runs');      % Times to run Metropolis to get best solve time
    hardness_params = {epsilon, beta_h, timeOut, num_runs};
    %   Transition temperature
    beta_transition = paramsMap('beta_transition');

    switch locality
        case 2
            % Define adjacency matrix - allowed couplings
            %    e.g. All-to-all
            %adj = ones(num_spins) - eye(num_spins);
            %adj = NearestNeighbourAdj2D(sqrt(num_spins), sqrt(num_spins));
            adj = chimeraAdj(5, 2);

            [solution, J_global, gs_energy] = lao_2(num_spins, num_loops, num_steps, adj, hardness_params, beta_transition);
 
        case 3
            % Define adjacency matrix - allowed couplings
            %    e.g. All-to-all
            % adj = all_to_all_3(num_spins);
            adj = nearestNeighbourAdj3local(sqrt(num_spins), sqrt(num_spins));

            [solution, J_global, gs_energy] = lao_3(num_spins, num_loops, num_steps, adj, hardness_params, beta_transition);

        otherwise
            disp('Can only handle 2-local and 3-local LAO algorithms!')
    end

    % Display ground state energy
    disp(sprintf( strcat( 'Groundstate energy: \t', num2str(gs_energy) )))

end
