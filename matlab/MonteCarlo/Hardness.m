function [ metric ] = Hardness(spinConfig, Hparams, gs_energy, epsilon, mySolver, timeOut, num_runs)
%HARDNESS Calculates hardness metric of some problem H.
% Metric is either:
%       - time to epsilon with flag
%       - epsilon at timeout with flag


global timeoutFlag
timeoutFlag = false;

%% TEST

solved_energy = realmax;
time_elapsed = 0;
        
% Run n times, recording best solution and time taken
for run = 1: num_runs

    tic    
    local_time = 0;
    
    % Set up timer and solve
    timeoutFlag = false;
    hTimer = timer('TimerFcn', @timeoutEventFunc, 'StartDelay', timeOut);
    start(hTimer)
    
    isExecuted = false;
    while ~isExecuted && ~timeoutFlag
        isExecuted = false;
        try            
            solution = feval('Solver', spinConfig, Hparams, mySolver);
            solution_energy = solution{1};
            local_time = toc;
            isExecuted = true;
        catch
            continue
        end
        
    end
    
    stop(hTimer)
    delete(hTimer)
    
    if ~isExecuted
        solution_energy = realmax;
        continue
    end
    
    if solution_energy < solved_energy
        solved_energy = solution_energy;
        time_elapsed = local_time;
    end

end       

% Check if Timeout

if solved_energy == realmax
    
    metric = {0, ['Timeout in ', num2str(timeOut), ' seconds.']};
    
else    
    deficit = (solved_energy - gs_energy);

    if deficit < epsilon

        metric = {time_elapsed, 'TTS'};

    else

        metric = {deficit, ['Accuracy achieved in ', num2str(time_elapsed), ' seconds.']};

    end
    
end

end

    


