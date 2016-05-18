function [ out ] = loop_adaptive_optimisation()

    % Add main directory to path
    addpath('../eigenspectrum/');
    
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
    
    
    % Generate (random) solution
    num_spins = 20;
    solution = round(rand(1,num_spins));
    
    % Place M random loops on graph, each respecting the planted solution
    
    
    % Calculate GS energy

end

