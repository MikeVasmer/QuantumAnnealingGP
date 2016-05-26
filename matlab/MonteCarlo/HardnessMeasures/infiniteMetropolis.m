function [ solution ] = infiniteMetropolis( spins, Hparams, beta, known_gs, epsilon, timeout )
    %INFINITEMETROPOLIS Implements Metropolis algorithm until some epsilon
    %distance from KNOWN ground state energy or time out

    % Parameter for transition probability
    Gamma = 1;
    % Unpack problem parameters
    [h, Jzz, ~, Jzzz, ~] = deal(Hparams{:});
    
    % Convinient variables
    spin_config = spins;
    solution_energy = realmax;

    % Whether a timeout happened
    timed_out = 'TTS';
    % Set up timer
    start_timer = tic;

    while true
        % Timeout timer
        if toc(start_timer) > timeout
            disp('Warning: Woooo BROOO!! Time out brooo!')
            timed_out = 'TIMEOUT';
            break;
        end
        
        % Update spin configuration
        newspins = spin_config;

        % Flip spins
        % Number of flips - normal distribution
        num_flips = ceil(abs(randn()));
        indices_to_flip = randperm(length(spin_config), num_flips).';
        for i = 1:length(indices_to_flip)
            flip_index = indices_to_flip(i);
            newspins(flip_index) = - spin_config(flip_index);
        end

        % Calculate probability of change in state
        p = transition_probability(indices_to_flip, newspins, Hparams, beta, Gamma, 'Metropolis');
        
        % If p = 1, update energy, else update based on random number
        if p > rand
            solution_energy = Conf_energy(newspins, Hparams);
            deficit = solution_energy - known_gs;
            spin_config = newspins;
            
            % If within deficit of ground state, break from algorithm
            if deficit <= epsilon 
                % Leave loop if within epsilon of solution 
                break;  
            end
        end
        
    end
    % Set total time elapsed
    time_elapsed = toc(start_timer);
    
    % Returns solution organised in a cell
    solution = {solution_energy, spin_config, time_elapsed, timed_out};
end

