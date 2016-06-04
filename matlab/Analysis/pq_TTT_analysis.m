close all
clearvars

directory_name = uigetdir;
files = dir(directory_name);
for j = length(files):-1:1
    if files(j).isdir
        files(j) = [];
    elseif ~isempty(strfind(files(j).name, 'solved'))
        files(j) = [];
    elseif ~isempty(strfind(files(j).name, 'average'))
        files(j) = [];
    elseif ~isempty(strfind(files(j).name, 'file_processor'))
        files(j) = [];
    elseif ~isempty(strfind(files(j).name, 'fig'))
        files(j) = [];
    end
end

hardness_point5_List = zeros(length(files),1);
hardness_point75_List = zeros(length(files),1);
hardness_TTS_List = zeros(length(files),1);

for j = length(files):-1:1
%for j=1:2
    file_name = files(j).name;
    mat_data = load(file_name);
    data = mat_data.run_info;
    try 
        temp_TTS_hard = data('new_hardness');
    catch
        temp_TTS_hard = data('hardness');
    end
    try
         hardness_TTS_List(j) = temp_TTS_hard{1}; 
    catch
         hardness_TTS_List(j) = temp_TTS_hard{1}{1}; 
    end
    %disp(file_name);
    fig_file_name = [file_name(1:end-4), '_Pq.fig'];
    %disp(fig_file_name);
    fig = openfig(fig_file_name);
    axesObjs = get(fig, 'children');
    dataObjs = get(axesObjs, 'children');
    values = get(dataObjs, 'Values');
    hardness_point5_List(j) = sum(values(51:151));
    hardness_point75_List(j) = sum(values(26:176));
    close all
end

figure(1);
scatter(hardness_TTS_List, hardness_point5_List);
title('Hardness comparison for 81 qubits');
xlabel('T2T Hardness (seconds)');
ylabel('P(q) [-0.5,0.5] Hardness (% support)');
savefig(1, [directory_name, filesep, 'T2T_vs_Pq_point5.fig']);
figure(2);
scatter(hardness_TTS_List, hardness_point75_List);
title('Hardness comparison for 81 qubits');
xlabel('T2T Hardness (seconds)');
ylabel('P(q) [-0.75,0.75] Hardness (% support)');
savefig(2, [directory_name, filesep, 'T2T_vs_Pq_point75.fig']);
