clearvars
close all

directory_name = uigetdir;
mat_files = dir(directory_name);
%Ignore . and .. directories
for i = length(mat_files):-1:1
    if mat_files(i).isdir
        mat_files(i) = [];
    elseif ~isempty(strfind(mat_files(i).name, 'solved'))
        mat_files(i) = [];
    elseif ~isempty(strfind(mat_files(i).name, 'average'))
        mat_files(i) = [];
    end
end
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

%Calculate P(q) distributions & kurtosis 
num_runs_Pq = 1000;
disorder_Pq = round(n_qubits / 2);
hardness_50_List = ones(num_files, 1).*2;
hardness_75_List = ones(num_files, 1).*2;
show_distributions = 1;
metropolis_timeSteps = 1000;

for i=1:num_files
    temp_hardness = plotQHistogram('Metropolis', hParams_List{i},...
        num_runs_Pq, n_qubits, disorder_Pq, show_distributions,...
        metropolis_timeSteps);
    hardness_75_List(i) = temp_hardness{1};
    hardness_50_List(i) = temp_hardness{2};
end


%Test equilibration
% timeSteps = 10000;
% eqmThreshold = 2000;
% observables_List = cell(1, num_files);
% disorder_eqm = disorder_Pq;

% for i=1:num_files
%     spins1 = generate_spins(n_qubits, disorder_eqm);
%     spins2 = generate_spins(n_qubits, disorder_eqm);
%     observables_List{i} = generateObservables(spins1, spins2,...
%         hParams_List{i}, 'Metropolis', timeSteps, eqmThreshold);
%     final_step = observables_List{i}{3};
%     times = linspace(1, final_step, final_step);
%     figure();
%     plot(times, observables_List{i}{1})
%     xlabel('Time Step');
%     ylabel('Order Parameter q');
%     title(sprintf('Order parameter equilibration for %d qubits', n_qubits))
%     figure();
%     plot(times, observables_List{i}{2})
%     xlabel('Time Step');
%     ylabel('Magnetisation');
%     title(sprintf('Magnetisation equilibration for %d qubits', n_qubits))
% end

% figure();
% plot(step_List, hardness_List);
% title(sprintf('Hardness for %d qubits, %d loops, %d iterations',...
%     n_qubits, LAO_loops, total_LAO_iterations));
% xlabel('Iteration');
% ylabel('Time2Target');
figure();
s1 = scatter(step_List, hardness_List);
title(sprintf('Hardness for %d qubits, %d loops, %d iterations',...
    n_qubits, LAO_loops, total_LAO_iterations));
xlabel('Iteration');
ylabel('Time2Target');
s1.LineWidth = 0.6;
s1.MarkerEdgeColor = 'b';
s1.MarkerFaceColor = 'b';

figure();
hold on
s2 = scatter(step_List, hardness_50_List);
s2.MarkerEdgeColor = 'g';
s2.MarkerFaceColor = 'g';
s3 = scatter(step_List, hardness_75_List);
s3.MarkerEdgeColor = 'r';
s3.MarkerFaceColor = 'r';
title(sprintf('Hardness for %d qubits, %d loops, %d iterations',...
    n_qubits, LAO_loops, total_LAO_iterations));
xlabel('Iteration');
ylabel('P(q) Hardness');
legend('Hardness50','Harndess75');





