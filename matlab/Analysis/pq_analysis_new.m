%Data analysis script which produces figures showing the Pq vs
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
num_subfolders = length(subfolders);
directories = cell(num_subfolders,1);

%Analysis variables for all data
hardness_50_List_All = zeros(1000000, 1);
hardness_75_List_All = zeros(1000000, 1);
hardness_List_All = zeros(1000000, 1);
step_List_All = zeros(1000000, 1);
k = 1;
%Pq params for all files
show_distributions = 1;
metropolis_timeSteps = 2500;
num_runs_Pq = 500;

for i = num_subfolders:-1:1
    %Build correct subfolder name
    folder_name = strcat(directory_name, strcat('\',subfolders(i).name));
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
    disorder_Pq = round(n_qubits / 2);
    total_LAO_iterations = LAOparams{3};
    LAO_loops = LAOparams{2};
    %Pq hardness variables
    hardness_50_List = zeros(num_files, 1);
    hardness_75_List = zeros(num_files, 1);
    
    %Process each file
    for j=1:num_files
       %Try/Catch here to account for different structures
       %TTS hardness
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
       %Pq hardness
       temp_histo = plotQHistogram('Metropolis', hParams_List{j},...
           num_runs_Pq, n_qubits, disorder_Pq, show_distributions,...
               metropolis_timeSteps);
       temp_vals = temp_histo.Values;
       hardness_75_List(j) = sum(temp_vals(26:176));
       hardness_50_List(j) = sum(temp_vals(51:151));
       hardness_75_List_All(k) = hardness_75_List(j);
       hardness_50_List_All(k) = hardness_50_List(j);
       file_name = strcat(folder_name, strcat('\',mat_files(j).name));
       savefig(strcat(file_name(1:end-4), '_Pq.fig'));
       %disp(file_name(1:end-4));
       close all;
       fprintf('Processed file %d of %d in subfolder %d of %d\n',...
           j, num_files, (num_subfolders - i + 1), num_subfolders);
       k = k + 1;
    end
    
    %Plot P(q) hardness
    figure(i);
    hold on
    s1 = scatter(step_List, hardness_50_List);
    s1.MarkerEdgeColor = 'g';
    s1.MarkerFaceColor = 'g';
    s2 = scatter(step_List, hardness_75_List);
    s2.MarkerEdgeColor = 'r';
    s2.MarkerFaceColor = 'r';
    title(sprintf('Hardness for %d qubits, %d loops', n_qubits, LAO_loops));
    xlabel('Iteration');
    ylabel('P(q) Hardness');
    legend('Hardness50','Harndess75');
    savefig(i, strcat(strcat(folder_name,'\'),...
        sprintf('Pq_Plot_%d_qubits_%d_loops.fig', n_qubits, LAO_loops)));
    close(i);
end
%Plot hardness figures for all data
hardness_List_All = hardness_List_All(1:k-1);
hardness_50_List_All = hardness_50_List_All(1:k-1);
hardness_75_List_All = hardness_75_List_All(1:k-1);
step_List_All = step_List_All(1:k-1);
%Plot P(q) only
figure(k);
hold on
s6 = scatter(step_List_All, hardness_50_List_All);
s6.MarkerEdgeColor = 'g';
s6.MarkerFaceColor = 'g';
s7 = scatter(step_List_All, hardness_75_List_All);
s7.MarkerEdgeColor = 'r';
s7.MarkerFaceColor = 'r';
title(sprintf('Hardness for %d qubits', n_qubits));
xlabel('Iteration');
ylabel('P(q) Hardness');
legend('Hardness50','Harndess75');
savefig(k, strcat(strcat(directory_name,'\'),...
    sprintf('Pq_Plot_%d_qubits.fig', n_qubits)));
close(k);