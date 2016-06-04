function [solution, J_global, gs_energy] = lao_no_optimisation_2(num_spins, num_loops, adj, hardness_params)
%% PLANTS A RANDOM SOLUTION WITH GROUND STATE 
      
    % ** Algorithm **
    % Generate (random) solution
    % Place M random loops on graph, each respecting the planted solution
    
    % Generate random solution, of size N
    solution = (round(rand(1,num_spins))*2)-1;
    
    % Initialise empty loop array
    loops = zeros(num_loops, num_spins+1);
    
    % Fill loop array with M loops
    loop_timer = tic;
    for i = 1:num_loops
        % Generate random walk loop
        loop = random_walk_loop_2( adj );
        % Pad with zeros
        loop = [loop, zeros(1, (num_spins+1)-length(loop))];
        % Add to loop array
        loops(i,:) = loop; 
        
        % Progress timer
        if toc(loop_timer) > 1
            disp(strcat(num2str(i),':',num2str(num_loops)));
            loop_timer = tic;
        end
    end
    
    % Calculate planted couplings and energies
    [J_global, gs_energy] = planted_hamiltonian_2(solution, loops);
    
    % Calculate hardness of original Ising problem
    %   Hardness function parameters
    epsilon  = hardness_params{1};
    beta_h   = hardness_params{2};
    timeOut  = hardness_params{3};
    num_runs = hardness_params{4};
    %   Set up H params
    hParams = {0, J_global, 0, 0, 0};
    %   Calculate hardness
    old_hardness = Hardness(hParams, gs_energy, epsilon, beta_h, timeOut, num_runs);
    
    keys = {...
            'stepInfo', ...
            'old_hardness', ...
            'new_hardness', ...
            'LAOparams', ...
            'ProbSolInfo' ...
    };

    values = { ...
        {0, 0}, ...                                                          % Step info
        {old_hardness}, ...                                                             % Hardness of instance
        {old_hardness}, ...                                                             % Hardness of instance
        {num_spins, num_loops, 0, adj, hardness_params, 0}, ...   % LAO parameters
        {solution, {0,J_global,0,0,0}, gs_energy} ...                                   % Problem/Solution info   
    };

    run_info = containers.Map(keys, values);

    % Filename malarky
%     currentTime = clock;
%     timeString = regexprep(num2str(currentTime(:)'),'(?:\s)+','_');
%     fileNameString = ['files', filesep, timeString, '_numqubits_', ...
%         num2str(num_spins), '_numloops_', num2str(num_loops), '_TTS_', ...
%         num2str(old_hardness{1}), '.mat']; 
% 
%     save(fileNameString, 'run_info');  
    
end
