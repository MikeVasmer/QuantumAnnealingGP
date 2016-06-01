function [ output_args ] = percGetSolverTimes( directoryName, solve_reps, epsilon )
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
    total_reps = 1
    
    
    subfolders = subfolders(arrayfun(@(x) x.name(1), subfolders) ~= '.');
    
    
    for i = length(subfolders):-1:1
        if ~isempty(strfind(subfolders(i).name, 'file_processor'))
            subfolders(i) = [];
        elseif ~isempty(strfind(subfolders(i).name, 'fig'))
            subfolders(i) = [];
        end
    end
    directories = cell(length(subfolders),1);
    
    
%     files = dir('*.mat')
    
    
    
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
        percSA = zeros(totDataFiles, 1);
        percPIQMC = zeros(totDataFiles, 1);
        percHB = zeros(totDataFiles, 1);
        
        

        count = 0;

        % Loops through files
        for file = mat_files'
            count = count + 1;

            % Creates arrays to hold information from each repeated solving
            % attempt, entries = total_reps
            

            % Does simulated annealing and stores TTS/RTS information
            
            percSA(count) = percFindGroundState(file.name, 'SimulatedAnnealing', solve_reps, 0, epsilon, 0);
            
            percPIQMC(count) = percFindGroundState(file.name, 'PIQMC', solve_reps, 0, epsilon, 0);
            
            percHB(count) = percFindGroundState(file.name, 'HeatBath', solve_reps, 0, epsilon, 0);
            
            

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
            

            % Creates a solved file corresponding to the data file, contains
            % information about every repeat of the solving attempt
            
            fileNameString_av = strcat(folder_name,filesep,'percentages.mat');   
            save(fileNameString_av, 'percSA', 'percPIQMC', 'percHB');
        end

        % Finally create a file containing average RTS/TTS for each solver and
        % data file 
        fileNameString = strcat(folder_name,filesep,'percentages.mat');

        save(fileNameString, 'percSA', 'percPIQMC', 'percHB');
    end

    

end

