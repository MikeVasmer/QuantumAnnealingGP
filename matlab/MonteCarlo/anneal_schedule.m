function [temperature] = anneal_schedule(type, t0, step, tempStep)
alpha = 0.1;
switch type
    case 'linear'
        temperature = t0 - tempStep;
    case 'exponential'
        temperature = t0 * alpha^(step);
    otherwise
        disp('Enter valid anneal schedule');
end

