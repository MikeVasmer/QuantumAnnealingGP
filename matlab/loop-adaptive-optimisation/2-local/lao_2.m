function [solution, J_global, gs_energy] = lao_2(num_spins, num_loops, num_steps, adj, hardness_params, beta_transition)

    % Add path for Hardness function
    addpath('../../MonteCarlo/HardnessMeasures')
    
    % ** Algorithm **
    % Generate (random) solution
    % Place M random loops on graph, each respecting the planted solution
    % Calculate GS energy
    % for step = 1 to NSTEP do
        % Remove random loop from current instance
        % Pick new random loop and add, respecting planted solution
        % Get new TTS
        % if TTS increases then
            % Accept Change, update GS energy
        % else
            % Accept with probability e^??|?TTS|
            % 13: Update GS energy if accepted
        % 14: end if
    % end for
    
    % Generate random solution, of size N
    solution = (round(rand(1,num_spins))*2)-1;
    
    % Initialise empty loop array
    loops = zeros(num_loops, num_spins+1);
    
    % Fill loop array with M loops
    disp('Generating initial loops...');
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
    
    % Start Optimisation stage
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
    
    % Track hardness evolution
    hardness_evolution = [old_hardness{1}];
    
    % Loop for for each step in num_steps
    disp('Starting optimisation step...');
    optimisation_timer = tic;
    progess_step = 0;
    change_accepted = false;
    for step = 1:num_steps
        % Make copy of loops array
        new_loops = loops;
        % Number of loops to replace
        num_replace = randi(3);
        for i = 1:num_replace
            % Generate new loop
            new_loop = random_walk_loop_2( adj );
            % Pad with zeros
            new_loop = [loop, zeros(1, (num_spins+1)-length(loop))];
            % Replace random loop from new loops array with new loop
            new_loops(randi(num_loops),:) = new_loop;
        end
        
        % Calculate planted couplings and energies
        [new_J_global, new_gs_energy] = planted_hamiltonian_2(solution, new_loops);
        
        % Calculate new Ising problem hardness
        new_hParams = {0, new_J_global, 0, 0, 0};
        new_hardness = Hardness(new_hParams, new_gs_energy, epsilon, beta_h, timeOut, num_runs);
        
        % Decision tree
        %   If TTS, then time decides
        %   If TIMEOUT, then energy deficit decides
        %   TIMEOUT trumps TTS
        if strcmp( old_hardness{3}, 'TTS' )
            if strcmp( new_hardness{3}, 'TTS' )
                new_TTS = new_hardness{1};
                old_TTS = old_hardness{1};
                if new_TTS > old_TTS
                    definitely_accept_change = true;
                else
                    definitely_accept_change = false;
                    delta_hardness = (old_TTS - new_TTS)/old_TTS;
                end
            elseif strcmp( new_hardness{3}, 'TIMEOUT' )
                definitely_accept_change = true;
            end
        elseif strcmp( old_hardness{3}, 'TIMEOUT' )
            if strcmp( new_hardness{3}, 'TTS' )
                definitely_accept_change = false;
                delta_hardness = realmax; % block change
            elseif strcmp( new_hardness{3}, 'TIMEOUT' )
                new_deficit = new_hardness{2};
                old_deficit = old_hardness{2};
                if new_deficit > old_deficit
                    definitely_accept_change = true;
                else
                    definitely_accept_change = false;
                    delta_hardness = (old_deficit - new_deficit)/old_deficit;
                end
            end
        end
           
        % If new problem harder, then accept
        if definitely_accept_change
            gs_energy = new_gs_energy;
            J_global = new_J_global;
            loops = new_loops;
            old_hardness = new_hardness;
            hardness_evolution = [hardness_evolution, old_hardness{1}];
            change_accepted = true;
        else % Else accept with Boltzmann dist
            if rand() < exp(-beta_transition*abs(delta_hardness))
                % Accept
                gs_energy = new_gs_energy;
                J_global = new_J_global;
                loops = new_loops;
                old_hardness = new_hardness;
                hardness_evolution = [hardness_evolution, old_hardness{1}];
                change_accepted = true;
            end
        end

        % Progress timer
        if toc(optimisation_timer) > 3 || step == num_steps
            disp(sprintf( strcat( ...
            'Optimisation step: \t\t', num2str(step), '\t of \t', num2str(num_steps), ...
            '\t\t Delta: \t', num2str(step-progess_step) ...
            )));
        
            disp(sprintf( strcat( ...
            'Current hardness: \t\t', 'TTS (sec): \t', num2str(old_hardness{1}), ...
            '\t Deficit: \t', num2str(old_hardness{2}), '\t Type: \t', num2str(old_hardness{3}) ...
            )));
            
            disp(sprintf( strcat( ...
            'Accepted updates: \t\t', num2str(length(hardness_evolution)) ...
            )));
        
            disp('-------------------------------------------------');
        
            optimisation_timer = tic;
            progess_step = step;
        end 
        
        if change_accepted
            
            keys = {...
                'stepInfo', ...
                'hardness', ...
                'LAOparams', ...
                'ProbSolInfo' ...
            };
            
            values = { ...
                {step, num_steps}, ...                                                          % Step info
                {hardness_evolution(end)}, ...                                                  % Hardness of instance
                {num_spins, num_loops, num_steps, adj, hardness_params, beta_transition}, ...   % LAO parameters
                {solution, {0,J_global,0,0,0}, gs_energy} ...                                   % Problem/Solution info   
            };
            
        run_info = containers.Map(keys, values);
        
        % Filename malarky
        currentTime = clock;
        timeString = regexprep(num2str(currentTime(:)'),'(?:\s)+','_');
        fileNameString = ['files', filesep, timeString, '_numqubits_', ...
            num2str(num_spins), '_numloops_', num2str(num_loops), '_TTS_', ...
            num2str(old_hardness{1}), '.mat']; 

        save(fileNameString, 'run_info');
        
        end
        
        % Reset change_accepted
        change_accepted = false;
    end   
    
%     figure(1);
%     plot(hardness_evolution)
%     xlabel('Steps');
%     ylabel('Hardness');
end

