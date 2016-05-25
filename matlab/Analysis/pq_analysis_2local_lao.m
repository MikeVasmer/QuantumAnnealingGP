clearvars
close all

directory_name = uigetdir;
mat_files = dir(directory_name);
%Ignore . and .. directories
mat_files = mat_files(arrayfun(@(x) x.name(1), mat_files) ~= '.');
num_files = length(mat_files);
data = cell(1, num_files);

for i=1:num_files
    datum = load(mat_files(i).name);
    data{i} = datum.run_info;
end

%Analysis variables
hardness_List = zeros(num_files, 1);
hParams_List = cell(1, num_files);
step_List = zeros(num_files, 1);
total_LAO_steps = data{1}('stepInfo');
total_LAO_steps = total_LAO_steps{2};
n_qubits_temp = data{1}('ProbSolInfo');
n_qubits = length(n_qubits{1});

for i=1:num_files
   temp_hard = data{i}('hardness');
   temp_ham = data{i}('ProbSolInfo');
   temp_step = data{i}('stepInfo');
   hardness_List(i) = temp_hard{1}; 
   hParams_List{i} = temp_ham{2};
   step_List(i) = temp_step{1};
end

figure();
plot(step_List, hardness_List);
title(sprintf('Hardness for %d qubits',...
       n_qubits, num_runs, algorithm, kurt));
xlabel('q');
ylabel('P(q)');
figure();
scatter(step_List, hardness_List);


