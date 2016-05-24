function [ solution ] = infiniteMetropolis( spins, Hparams, beta, known_gs, epsilon, timeOut )
%INFINITEMETROPOLIS Implements Metropolis algorithm until some epsilon
%distance from KNOWN ground state energy or time out

global timeoutFlag
timeoutFlag = false;

counter = 0;
Gamma = 1;
[h, Jzz, ~, Jzzz, ~] = deal(Hparams{:});

spin_config = spins;
solution_energy = realmax;

time_elapsed = 0;
timed_out = 'TTS';
start_timer = tic;

% Set up timer and solve
hTimer = timer('TimerFcn', @timeoutEventFunc, 'StartDelay', timeOut);
start(hTimer)

while true
    
    newspins = spin_config;
    
    % Flip spins
    num_flips = 1; % TODO: Change to larger values eg. num_flips = 2, every 1000 iterations if slow
    indices_to_flip = randperm(length(spin_config), num_flips).';
    for i = 1:length(indices_to_flip)
        flip_index = indices_to_flip(i);
        newspins(flip_index) = - spin_config(flip_index);
    end

    % Calculate probability of change in state
    try
        p = transition_probability(indices_to_flip, newspins, Hparams, beta, Gamma, 'Metropolis');
        x = rand;
    catch
        time_elapsed = toc(start_timer);
        timed_out = 'TIMEOUT';
        break % Leaves loop if timeoutFlag is TRUE
    end
    try
        if p > x
            solution_energy = Conf_energy(newspins, Hparams);
            deficit = solution_energy - known_gs;
            spin_config = newspins;
            
            if deficit <= epsilon % Leave loop if within epsilon of solution 
                 break     
            end
            
        end
        
    catch
        time_elapsed = toc(start_timer);
        timed_out = 'TIMEOUT';
        break % Leaves loop if timeoutFlag is TRUE
    end
    
    % Timing data
    time_elapsed = toc(start_timer);
    counter = counter + 1;
    
end
   
stop(hTimer)
delete(hTimer)

solution = {solution_energy, spin_config, time_elapsed, timed_out};

clear global timeoutFlag

end

