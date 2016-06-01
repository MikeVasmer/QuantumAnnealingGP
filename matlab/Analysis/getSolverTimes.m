function [ output_args ] = getSolverTimes( directoryName, solve_reps, total_reps, epsilon )
%getSolverTimes: this function loops through all files in the current
%folder and returns solve-time information for solvers.
%   Currently only clever enough to work if you are in the directory you
%   want to run in.
%   Solve_reps = number of times each solver should try to solve the
%   problem before it stops
%   total_reps = total number of times each solver is run, to get
%   statistics on average reps and time
%   epsilon = closeness to ground state required for 'solved'

    

    % Get parent directory
    directory_name = directoryName;
    subfolders = dir(directory_name)
    
    
    subfolders = subfolders(arrayfun(@(x) x.name(1), subfolders) ~= '.');
    
    
    for i = length(subfolders):-1:1
        if ~isempty(strfind(subfolders(i).name, 'file_processor'))
            subfolders(i) = [];
        elseif ~isempty(strfind(subfolders(i).name, 'fig'))
            subfolders(i) = [];
        end
    end
    directories = cell(length(subfolders),1);
    
    
    files = dir('*.mat');
    
    
    
    for i = length(subfolders):-1:1
        % Gets current folder name
        folder_name = strcat(directory_name, strcat(filesep,subfolders(i).name));
        directories{i} = folder_name;
        mat_files = dir(folder_name);
        %Remove hidden . and .. folders
        for j = length(mat_files):-1:1
            if mat_files(j).isdir
                mat_files(j) = [];
            elseif ~isempty(strfind(mat_files(j).name, 'solved'))
                mat_files(j) = [];
            elseif ~isempty(strfind(mat_files(j).name, 'average'))
                mat_files(j) = [];
            elseif ~isempty(strfind(mat_files(j).name, 'file_processor'))
                mat_files(j) = [];
            elseif ~isempty(strfind(mat_files(j).name, 'fig'))
                mat_files(j) = [];
            elseif ~isempty(strfind(mat_files(j).name, 'percentages'))
                mat_files(j) = [];
            end
        end
        
        currentDirectory = pwd;
        [upperPath, deepestFolder, ~] = fileparts(currentDirectory);

        

        % Finds total number of data files (not including solved files)
        totDataFiles = length(mat_files);

        % Initialises arrays to hold average times and reps for each solver.
        % Vector, each entry corresponding to different file
        avRepsSA = zeros(totDataFiles, 1);
        avTimeSA = zeros(totDataFiles, 1);
        avRepsPIQMC = zeros(totDataFiles, 1);
        avTimePIQMC = zeros(totDataFiles, 1);
        avRepsHB = zeros(totDataFiles, 1);
        avTimeHB = zeros(totDataFiles, 1);
        avRepsPT = zeros(totDataFiles, 1);
        avTimePT = zeros(totDataFiles, 1);

        count = 0;

        % Loops through files
        for file = mat_files'
            count = count + 1;

            % Creates arrays to hold information from each repeated solving
            % attempt, entries = total_reps
            RepsSA = zeros(total_reps,1);
            TimeSA = zeros(total_reps,1);
            RepsPIQMC = zeros(total_reps,1);
            TimePIQMC = zeros(total_reps,1);
            RepsHB = zeros(total_reps,1);
            TimeHB = zeros(total_reps,1);
            RepsPT = zeros(total_reps,1);
            TimePT = zeros(total_reps,1);

            % Does simulated annealing and stores TTS/RTS information
            parfor repetition = 1:total_reps
                solutionSA = findGroundState(file.name, 'SimulatedAnnealing', solve_reps, 0, epsilon, 0);
                RepsSA(repetition) = solutionSA{1};
                TimeSA(repetition) = solutionSA{2};
                solutionPIQMC = findGroundState(file.name, 'PIQMC', solve_reps, 0, epsilon, 1);
                RepsPIQMC(repetition) = solutionPIQMC{1};
                TimePIQMC(repetition) = solutionPIQMC{2};
                solutionHB = findGroundState(file.name, 'HeatBath', solve_reps, 0, epsilon, 0);
                RepsHB(repetition) = solutionHB{1};
                TimeHB(repetition) = solutionHB{2};
            end

%             % Does PIQMC and stores TTS/RTS information
%             parfor repetition = 1:total_reps
%                 solution = findGroundState(file.name, 'PIQMC', solve_reps, 0, epsilon, 0);
%                 RepsPIQMC(repetition) = solution{1};
%                 TimePIQMC(repetition) = solution{2};
%             end
% 
%             % Does HeatBath and stores TTS/RTS information
%             parfor repetition = 1:total_reps
%                 solution = findGroundState(file.name, 'HeatBath', solve_reps, 0, epsilon, 0);
%                 RepsHB(repetition) = solution{1};
%                 TimeHB(repetition) = solution{2};
%             end
%             
%             parfor repetition = 1:total_reps
%                 solution = findGroundState(file.name, 'ParallelTempering', solve_reps, 0, epsilon, 0);
%                 RepsPT(repetition) = solution{1};
%                 TimePT(repetition) = solution{2};
%             end

            % Finds average TTS/RTS for each solver and adds to average arrays
            % above
            avRepsSA(count) = mean(RepsSA);
            avTimeSA(count) = mean(TimeSA);
            avRepsPIQMC(count) = mean(RepsPIQMC);
            avTimePIQMC(count) = mean(TimePIQMC);
            avRepsHB(count) = mean(RepsHB);
            avTimeHB(count) = mean(TimeHB);
            avRepsPT(count) = mean(RepsPT);
            avTimePT(count) = mean(TimePT);

            % Creates a solved file corresponding to the data file, contains
            % information about every repeat of the solving attempt
            fileNameString = strcat(folder_name,filesep,'solved', file.name);
            save(fileNameString, 'RepsSA', 'TimeSA', 'RepsPIQMC', 'TimePIQMC', 'RepsHB', 'TimeHB', 'RepsPT', 'TimePT');
            fileNameString_av = strcat(folder_name,filesep,'averages.mat');   
            save(fileNameString_av, 'avRepsSA', 'avTimeSA', 'avRepsPIQMC', 'avTimePIQMC', 'avRepsHB', 'avTimeHB', 'avRepsPT', 'avTimePT');
        end

        % Finally create a file containing average RTS/TTS for each solver and
        % data file 
        fileNameString = strcat(folder_name,filesep,'averages.mat');

        save(fileNameString, 'avRepsSA', 'avTimeSA', 'avRepsPIQMC', 'avTimePIQMC', 'avRepsHB', 'avTimeHB');
    end

    

end

