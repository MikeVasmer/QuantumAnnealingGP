function [ metric ] = Hardness(spinConfig, Hparams, gs_energy, epsilon, mySolver, timeOut, num_runs)
%HARDNESS Calculates hardness metric of some problem H.
% Metric is either:
%       - time to epsilon with flag
%       - epsilon at timeout with flag


%% TEST

solved_energy = realmax;
time_elapsed = 0;
        
% Run n times, recording best solution and time taken
for run = 1: num_runs

    tic    
    local_time = 0;
    
    try
        solution = timeout('Solver', timeOut, spinConfig, Hparams, mySolver);
        solution_energy = solution{1};
        local_time = toc;
    catch
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

    
%  try 
%      metric = timeout(@test_hardness, (num_runs*timeOut));    
%  catch
%      metric = {(solved_energy - gs_energy), ['Timeout in ', num2str(timeOut*num_runs), ' seconds.']} ;
%  end

end

    


