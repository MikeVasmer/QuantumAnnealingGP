function [solution, J_global, gs_energy] = loop_adaptive_optimisation(num_spins, num_loops, num_steps)

    % Add eigenspectrum directory for just_couplings() function
    addpath('../eigenspectrum/')
    
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
    
    % Define adjacency matrix - allowed couplings
    %    e.g. All-to-all
    adj = just_couplings( ones(num_spins, num_spins) );
    
    % Initialise empty loop array
    loops = zeros(num_loops, num_spins+1);
    
    % Fill loop array with M loops
    disp('Generating initial loops...');
    tic;
    for i = 1:num_loops
        % Generate random walk loop
        loop = random_walk_loop( adj );
        % Pad with zeros
        loop = [loop, zeros(1, (num_spins+1)-length(loop))];
        % Add to loop array
        loops(i,:) = loop; 
        
        % Progress timer
        if toc > 1
            disp(strcat(num2str(i),':',num2str(num_loops)));
            tic;
        end
    end
    
    % Calculate planted couplings and energies
    [J_global, gs_energy] = planted_hamiltonian(solution, loops);
    
    % Start Optimisation stage
    % Temperature
    beta = 1.0;
    % Calculate hardness of original Ising problem
    hardness_type = 'PIMC';
    old_hardness = hardness_measure(hardness_type, J_global, gs_energy);
    
    % Loop for for each step in num_steps
    disp('Starting optimisation step...');
    tic;
    for step = 1:num_steps
        % Make copy of loops array
        new_loops = loops;
        % Generate new loop
        new_loop = random_walk_loop( adj );
        % Pad with zeros
        new_loop = [loop, zeros(1, (num_spins+1)-length(loop))];
        % Replace random loop from new loops array with new loop
        new_loops(randi(num_loops),:) = new_loop;
        
        % Calculate planted couplings and energies
        [new_J_global, new_gs_energy] = planted_hamiltonian(solution, new_loops);
        
        % Calculate new Ising problem hardness
        new_hardness = hardness_measure(hardness_type, new_J_global, new_gs_energy);
        % If new problem harder, then accept
        if new_hardness > old_hardness
            % Accept
            gs_energy = new_gs_energy;
            J_global = new_J_global;
            loops = new_loops;
            old_hardness = new_hardness;
        else % Else accept with Boltzmann dist
            deltaHardness = old_hardness - new_hardness;
            if rand() < exp(-beta*abs(deltaHardness))
                % Accept
                gs_energy = new_gs_energy;
                J_global = new_J_global;
                loops = new_loops;
                old_hardness = new_hardness;
            end
        end

        % Progress timer
        if toc > 2
            disp(strcat(num2str(step),':',num2str(num_steps)));
            tic;
        end 
    end   
end

