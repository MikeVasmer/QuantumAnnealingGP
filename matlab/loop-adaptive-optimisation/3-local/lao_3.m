function [solution, J_global, gs_energy]s = lao_3(num_spins, num_loops, num_steps, adj, hardness_params, beta_transition)

    % Add path for symmetrize_3local_couplings function
    addpath('../../MonteCarlo/')
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
    loops = cell(1,num_loops);
    
    % Fill loop array with M loops
    disp('Generating initial loops...');
    loop_timer = tic;
    for i = 1:num_loops
        % Generate random walk loop
        loop = random_walk_loop_3( adj );
        % Add to loop array
        loops{i} = loop; 
        
        % Progress timer
        if toc(loop_timer) > 1
            disp(strcat(num2str(i),':',num2str(num_loops)));
            loop_timer = tic;
        end
    end
    
    % Calculate planted couplings and energies
    disp('Calculating planted Hamiltonian...');
    [J_global, gs_energy] = planted_hamiltonian_3(solution, loops);
    
    % Start Optimisation stage
    disp('Starting optimisation step...');
    % Calculate hardness of original Ising problem
    %   Hardness function parameters
    epsilon  = hardness_params{1};
    beta_h   = hardness_params{2};
    timeOut  = hardness_params{3};
    num_runs = hardness_params{4};
    %   Set up H params
    hParams = {0, 0, 0, J_global, 0};
    %   Calculate hardness
    old_hardness = Hardness(hParams, gs_energy, epsilon, beta_h, timeOut, num_runs);
    
    % Track hardness evolution
    hardness_evolution = [old_hardness{1}];
    
    % Loop for for each step in num_steps
    optimisation_timer = tic;
    progess_step = 0;
    change_accepted = false;
    for step = 1:num_steps
        % Make copy of loops array
        new_loops = loops;
        % Number of loops to replace - normal distribution
        num_replace = ceil(abs(randn()));
        for i = 1:num_replace
            % Generate new loop
            new_loop = random_walk_loop_3( adj );
            % Replace random loop from new loops array with new loop
            new_loops{randi(num_loops)} = new_loop;
        end

        % Calculate planted couplings and energies
        [new_J_global, new_gs_energy] = planted_hamiltonian_3(solution, new_loops);
        
        % Calculate new Ising problem hardness
        new_hParams = {0, 0, 0, new_J_global, 0};
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
        update_time = 3;
        if toc(optimisation_timer) > update_time || step == num_steps
            if exist('delta_steps')
                delta_steps = [delta_steps, step-progess_step];
            else
                delta_steps = [step-progess_step];
            end
            
            disp(sprintf( strcat( ...
            'Optimisation step: \t\t', num2str(step), '\t of \t', num2str(num_steps), ...
            '\t\t Delta: \t', num2str(delta_steps(end)) ...
            )));
        
            disp(sprintf( strcat( ...
            'Current hardness: \t\t', 'TTS (sec): \t', num2str(old_hardness{1}), ...
            '\t Deficit: \t', num2str(old_hardness{2}), '\t Type: \t', num2str(old_hardness{3}) ...
            )));
            
            disp(sprintf( strcat( ...
            'Accepted updates: \t\t', num2str(length(hardness_evolution)) ...
            )));
        
            time_remaining = update_time*((num_steps-step)/mean(delta_steps));
            time_hour = floor(time_remaining/3600);
            time_min  = floor((time_remaining-(time_hour*60))/60);
            time_sec  = round(mod(time_remaining,60));
        
            disp(sprintf( strcat( ...
            'Estimated time remaining: \t', ...
                num2str(time_hour), 'h \t', ...
                num2str(time_min), 'm \t', ...
                num2str(time_sec), 's \t' ...
            )));
        
            disp('-------------------------------------------------');
        
            optimisation_timer = tic;
            progess_step = step;
        end 
        
        if change_accepted
            
            keys = {...
                'stepInfo', ...
                'old_hardness', ...
                'new_hardness', ...
                'LAOparams', ...
                'ProbSolInfo' ...
            };
            
            values = { ...
                {step, num_steps}, ...                                                          % Step info
                {old_hardness}, ... 
                {new_hardness}, ... % Hardness of instance
                {num_spins, num_loops, num_steps, adj, hardness_params, beta_transition}, ...   % LAO parameters
                {solution, {0,0,0,J_global,0}, gs_energy} ...                                   % Problem/Solution info   
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
    
    figure(1);
    plot(hardness_evolution)
    xlabel('Steps');
    ylabel('Hardness');
end

