function [solution, J_global, gs_energy] = loop_adaptive_optimisation(num_spins, num_loops)

    % Add PIMC/ to path for Conf_energy function
    addpath('../PIMC/');
    
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
    % 15: end for
    
    % Generate random solution, of size N
    solution = (round(rand(1,num_spins))*2)-1;
    
    % Define adjacency matrix - allowed couplings
    %    e.g. All-to-all
    adj = just_couplings( ones(num_spins, num_spins) );
    
    % Initialise empty loop array
    loops = zeros(num_loops, num_spins+1);
    
    % Fill loop array with M loops
    disp('Generating loops...');
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
    
    % Calculate global couplings
    J_global = global_hamiltonian(solution, loops);

    % Calculate groundstate energy
    disp('Calculating groundstate energy...');
    spin_config = solution;
    h = zeros(1, num_spins);
    Jzz  = J_global;
    Jxx  = 0;
    Jzzz = 0;
    Jxxx = 0;
    hParams = {h, Jzz, Jxx, Jzzz, Jxxx};
    gs_energy = Conf_energy( spin_config, hParams );
    
end

