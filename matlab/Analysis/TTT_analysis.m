%Data analysis script which produces figures showing the time2target vs
%iteration for different Hamiltonians. To use point the script at a folder
%such as '10Qubits' 'NN' in the
%'loop-adaptive-optimisation\files\2Local' or
%'loop-adaptive-optimisation\files\3Local' folders
close all 
clearvars

%Get parent directory (ie directory containing all subfolders to be
%analysed)
directory_name = uigetdir;
subfolders = dir(directory_name);
%Remove hidden . and .. folders
subfolders = subfolders(arrayfun(@(x) x.name(1), subfolders) ~= '.');
%Remove bash file processing script and figures
for i = length(subfolders):-1:1
    if ~isempty(strfind(subfolders(i).name, 'file_processor'))
        subfolders(i) = [];
    elseif ~isempty(strfind(subfolders(i).name, 'fig'))
        subfolders(i) = [];
    end
end
directories = cell(length(subfolders),1);

%Analysis variables for all data
hardness_List_All = zeros(1000000, 1);
step_List_All = zeros(1000000, 1);
k = 1;

for i = length(subfolders):-1:1
    %Build correct subfolder name
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
    %mat_files = mat_files(arrayfun(@(x) x.name(1), mat_files) ~= '.');
    %Load individual files
    num_files = length(mat_files);
    data = cell(1, num_files);
    for j=1:num_files
        datum = load(mat_files(j).name);
        data{j} = datum.run_info;
        %celldisp(data{j}('ProbSolInfo'));
    end
    
    %Analysis variables
    hardness_List = zeros(num_files, 1);
    hParams_List = cell(1, num_files);
    step_List = zeros(num_files, 1);
    LAOparams = data{1}('LAOparams');
    n_qubits = LAOparams{1};
    total_LAO_iterations = LAOparams{3};
    LAO_loops = LAOparams{2};
    
    %Process each file
    for j=1:num_files
        %Try/Catch here to account for different structures
       try 
           temp_hard = data{j}('new_hardness');
       catch
           temp_hard = data{j}('hardness');
           exception = 1;
       end
       temp_ham = data{j}('ProbSolInfo');
       temp_step = data{j}('stepInfo');
       try
           hardness_List(j) = temp_hard{1}; 
       catch
           hardness_List(j) = temp_hard{1}{1}; 
       end
       hParams_List{j} = temp_ham{2};
       step_List(j) = temp_step{1};
       hardness_List_All(k) = hardness_List(j);
       step_List_All(k) = step_List(j);
       k = k + 1;
    end
    
    %Plot hardness figure
    figure(i);
    s1 = scatter(step_List, hardness_List);
    title(sprintf('Hardness for %d qubits, %d loops', n_qubits, LAO_loops));
    xlabel('Iteration');
    ylabel('Time2Target');
    s1.LineWidth = 0.6;
    s1.MarkerEdgeColor = 'b';
    s1.MarkerFaceColor = 'b';
    %Save figure
    savefig(i, strcat(strcat(folder_name,filesep),...
        sprintf('T2T_Plot_%d_qubits_%d_loops.fig', n_qubits, LAO_loops)));
    close(i);
end
%Plot hardness figure for all data
hardness_List_All = hardness_List_All(1:k-1);
step_List_All = step_List_All(1:k-1);
figure(k);
s2 = scatter(step_List_All, hardness_List_All);
title(sprintf('Hardness for %d qubits',n_qubits));
xlabel('Iteration');
ylabel('Time2Target');
s2.LineWidth = 0.6;
s2.MarkerEdgeColor = 'r';
s2.MarkerFaceColor = 'r';
%Save figure
savefig(k, strcat(strcat(directory_name,filesep),...
        sprintf('T2T_Plot_%d_qubits.fig', n_qubits)));
close(k);