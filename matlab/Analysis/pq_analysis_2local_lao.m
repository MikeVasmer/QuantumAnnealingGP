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
LAOparams = data{1}('LAOparams');
n_qubits = LAOparams{1};
total_LAO_iterations = LAOparams{3};
LAO_loops = LAOparams{2};

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
title(sprintf('Hardness for %d qubits, %d loops, %d iteraions',...
    n_qubits, LAO_loops, total_LAO_iterations));
xlabel('Iteration');
ylabel('Time2Target');
figure();
s = scatter(step_List, hardness_List);
title(sprintf('Hardness for %d qubits, %d loops, %d iteraions',...
    n_qubits, LAO_loops, total_LAO_iterations));
xlabel('Iteration');
ylabel('Time2Target');
s.LineWidth = 0.6;
s.MarkerEdgeColor = 'b';
s.MarkerFaceColor = [0 0.5 0.5];


