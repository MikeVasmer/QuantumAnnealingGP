function [ output_args ] = getSolverTimes( dirName, solve_reps, total_reps, epsilon )
%getSolverTimes: this function loops through all files in the current
%folder and returns solve-time information for solvers.
%   Currently only clever enough to work if you are in the directory you
%   want to run in.
%   Solve_reps = number of times each solver should try to solve the
%   problem before it stops
%   total_reps = total number of times each solver is run, to get
%   statistics on average reps and time
%   epsilon = closeness to ground state required for 'solved'

    
%   list of all .mat files
    files = dir('*.mat')
    
    currentDirectory = pwd;
    
    % Gets current folder name
    [upperPath, deepestFolder, ~] = fileparts(currentDirectory);
    
    % Gets any 'solved' files - best if these aren't here!
    solvedFiles = dir('*solved*.mat');
    
    % Finds total number of data files (not including solved files)
    totDataFiles = length(files) - length(solvedFiles);
    
    % Initialises arrays to hold average times and reps for each solver.
    % Vector, each entry corresponding to different file
    avRepsSA = zeros(totDataFiles, 1);
    avTimeSA = zeros(totDataFiles, 1);
    avRepsPIQMC = zeros(totDataFiles, 1);
    avTimePIQMC = zeros(totDataFiles, 1);
    avRepsHB = zeros(totDataFiles, 1);
    avTimeHB = zeros(totDataFiles, 1);
    
    count = 0;
    
    % Loops through files
    for file = files'
        count = count + 1;
        
        % Creates arrays to hold information from each repeated solving
        % attempt, entries = total_reps
        RepsSA = zeros(total_reps,1);
        TimeSA = zeros(total_reps,1);
        RepsPIQMC = zeros(total_reps,1);
        TimePIQMC = zeros(total_reps,1);
        RepsHB = zeros(total_reps,1);
        TimeHB = zeros(total_reps,1);
        
        % Does simulated annealing and stores TTS/RTS information
        for repetition = 1:total_reps
            solution = findGroundState(file.name, 'SimulatedAnnealing', solve_reps, 0, epsilon, 0);
            RepsSA(repetition) = solution{1};
            TimeSA(repetition) = solution{2};
        end
        
        % Does PIQMC and stores TTS/RTS information
        for repetition = 1:total_reps
            solution = findGroundState(file.name, 'PIQMC', solve_reps, 0, epsilon, 0);
            RepsPIQMC(repetition) = solution{1};
            TimePIQMC(repetition) = solution{2};
        end
        
        % Does HeatBath and stores TTS/RTS information
        for repetition = 1:total_reps
            solution = findGroundState(file.name, 'HeatBath', solve_reps, 0, epsilon, 0);
            RepsHB(repetition) = solution{1};
            TimeHB(repetition) = solution{2};
        end
        
        % Finds average TTS/RTS for each solver and adds to average arrays
        % above
        avRepsSA(count) = mean(RepsSA);
        avTimeSA(count) = mean(TimeSA);
        avRepsPIQMC(count) = mean(RepsPIQMC);
        avTimePIQMC(count) = mean(TimePIQMC);
        avRepsHB(count) = mean(RepsHB);
        avTimeHB(count) = mean(TimeHB);
        
        % Creates a solved file corresponding to the data file, contains
        % information about every repeat of the solving attempt
        fileNameString = strcat('solvedSA', file.name);
        save(fileNameString, 'RepsSA', 'TimeSA', 'RepsPIQMC', 'TimePIQMC', 'RepsHB', 'TimeHB');
    end
    
    % Finally create a file containing average RTS/TTS for each solver and
    % data file 
    fileNameString = strcat('averages', deepestFolder);
    
    save(fileNameString, 'avRepsSA', 'avTimeSA', 'avRepsPIQMC', 'avTimePIQMC', 'avRepsHB', 'avTimeHB');
        
    

end

