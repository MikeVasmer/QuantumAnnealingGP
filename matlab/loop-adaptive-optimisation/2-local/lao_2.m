function [solution, J_global, gs_energy] = lao_2(num_spins, num_loops, num_steps, adj, hardness_params, beta_transition)
    
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
    disp('Calculating initial hardness...');
    % Calculate hardness of original Ising problem
    %   Hardness function parameters
    epsilon  = hardness_params{1};
    beta_h   = hardness_params{2};
    timeOut  = hardness_params{3};
    num_runs = hardness_params{4};
    %   Set up H params
    hParams = {0, J_global, 0, 0, 0};
    %   Calculate hardness
    old_hardness = Hardness(hParams, gs_energy, epsilon, beta_h, timeOut, num_runs, 'Perc', num_spins);
    
    % Track hardness evolution
    hardness_evolution = [old_hardness{1}];
    
    % Loop for for each step in num_steps
    % Used to calculate delta_step between progress reports
    progess_step = 0;
    % Whether a change within a loop was accepted
    change_accepted = false;
    % Flag to determine when to loop again
    continue_looping = true;
    % Keep track of number of steps since the last update
    steps_since_update = 0;
    % Keep track of time since the last progress report
    time_since_progress = tic;
    % Track number of steps excecuted
    step = 0;
    % Used in time to termination calculation
    delta_steps = [];
    time_since_progress_array = [];
    disp('Starting optimisation step...');
    while continue_looping
        % Increment step count
        step = step + 1;
        % Increment steps since last update count
        steps_since_update = steps_since_update + 1;
        % Make copy of loops array
        new_loops = loops;
        % Number of loops to replace - normal distribution
        num_replace = ceil(abs(randn()));
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
        new_hardness = Hardness(new_hParams, new_gs_energy, epsilon, beta_h, timeOut, num_runs, 'Perc', num_spins);
        
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
                definitely_accept_change = false;
                delta_hardness = realmax; % block change
            end
        elseif strcmp( old_hardness{3}, 'TIMEOUT' )
            if strcmp( new_hardness{3}, 'TTS' )
                definitely_accept_change = true;
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
            change_accepted = true;
        else % Else accept with Boltzmann dist
            if rand() < exp(-beta_transition*abs(delta_hardness))
                change_accepted = true;
            end
        end
        
        % If change was accepted, then update required variables
        if change_accepted
            % Update new groundstate energy
            gs_energy = new_gs_energy;
            % Update new couplings, J
            J_global = new_J_global;
            % Update new loops
            loops = new_loops;
            % Update new hardness
            old_hardness = new_hardness;
            % Keep track of hardness after each update
            hardness_evolution = [hardness_evolution, old_hardness{1}];
            % Reset steps since last update
            steps_since_update = 0;
            % Reset delta_steps and time_since_progress_array used in time to termination calculation
            delta_steps = [];
            time_since_progress_array = [];
        end
        
        % If the number of steps since the last update is larger than
        % num_loops, then stop optimisation process
        if steps_since_update >= num_steps
            continue_looping = false;
            disp(sprintf(strcat( ...
                'Info: Number of steps since last update has reached \t', ...
                num2str(steps_since_update), ...
                '. Therefore optimisation stage was terminated.' ...
            )));
        end

        % Progress timer
        update_time = 3;
        if toc(time_since_progress) > update_time || step == num_steps || ~continue_looping
            % Update list of delta_steps and time_since_progress_array
            delta_steps = [delta_steps, step-progess_step];
            time_since_progress_array = [time_since_progress_array, toc(time_since_progress)];

            disp(sprintf(strcat( ...
            'Optimisation step: \t\t', num2str(step), '\t\t Delta: \t', num2str(delta_steps(end)) ...
            )));
        
            disp(sprintf(strcat( ...
            'Steps since update: \t', num2str(steps_since_update), ...
            '\t of \t', num2str(num_steps), ...
            '\t before termination.' ...
            )));
        
            disp(sprintf(strcat( ...
            'Current hardness: \t\t', 'TTS (sec): \t', num2str(old_hardness{1}), ...
            '\t Deficit: \t', num2str(old_hardness{2}), '\t Type: \t', num2str(old_hardness{3}) ...
            )));
            
            disp(sprintf(strcat( ...
            'Accepted updates: \t\t', num2str(length(hardness_evolution)-1) ...
            )));
        
            time_remaining = mean(time_since_progress_array)*((num_steps-steps_since_update)/mean(delta_steps));
            time_hour = floor(time_remaining/3600);
            time_min  = floor((time_remaining-(time_hour*3600))/60);
            time_sec  = round(mod(time_remaining,60));
        
            disp(sprintf(strcat( ...
            'Time to termination: \t', ...
                num2str(time_hour), 'h \t', ...
                num2str(time_min), 'm \t', ...
                num2str(time_sec), 's \t' ...
            )));
        
            disp('-------------------------------------------------');
        
            % Update step of last progress
            progess_step = step;
            
            % Reset time since last progress report
            time_since_progress = tic;
        end 
        
        % If change was accepted, then save to file the new Ising problem
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
                {old_hardness}, ...                                                             % Hardness of instance
                {new_hardness}, ...                                                             % Hardness of instance
                {num_spins, num_loops, num_steps, adj, hardness_params, beta_transition}, ...   % LAO parameters
                {solution, {0,J_global,0,0,0}, gs_energy} ...                                   % Problem/Solution info   
            };

            run_info = containers.Map(keys, values);

            % Filename malarky
            currentTime = clock;
            timeString = regexprep(num2str(currentTime(:)'),'(?:\s)+','_');
            fileNameString = ['files/2Local/Chimera/80-qubits', filesep, timeString, '_numqubits_', ...
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
