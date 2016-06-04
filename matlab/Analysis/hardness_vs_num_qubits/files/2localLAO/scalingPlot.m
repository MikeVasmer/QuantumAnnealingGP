files = dir;
directoryNames = {files([files.isdir]).name};
directoryNames = directoryNames(~ismember(directoryNames,{'.','..'}));

averagesCell = cell(length(directoryNames),1);

simulatedAnnealingReps = zeros(length(directoryNames), 1);
simulatedAnnealingRepsErr = simulatedAnnealingReps;
heatBathReps = zeros(length(directoryNames), 1);
heatBathRepsErr = heatBathReps; 
PIMCReps = zeros(length(directoryNames), 1);
PIMCRepsErr = PIMCReps;

simulatedAnnealingTime = zeros(length(directoryNames), 1);
simulatedAnnealingTimeErr = simulatedAnnealingTime;
heatBathTime = zeros(length(directoryNames), 1);
heatBathTimeErr = heatBathTime; 
PIMCTime = zeros(length(directoryNames), 1);
PIMCTimeErr = PIMCTime;

%% LOAD DATA
for i = 1:length(directoryNames)
    
    averages = load([directoryNames{i}, filesep, 'averages.mat']);
    averagesCell{i} = averages;
    
    heatBathReps(i) = mean(averages.avRepsHB);
    heatBathRepsErr(i) = std(averages.avRepsHB)/sqrt(length(averages.avRepsHB));
    
    simulatedAnnealingReps(i) = mean(averages.avRepsSA);
    simulatedAnnealingRepsErr(i) = std(averages.avRepsSA)/sqrt(length(averages.avRepsSA));
    
    PIMCReps(i) = mean(averages.avRepsPIQMC);
    PIMCRepsErr(i) = std(averages.avRepsPIQMC)/sqrt(length(averages.avRepsPIQMC));
    
    heatBathTime(i) = mean(averages.avTimeHB);
    heatBathTimeErr(i) = std(averages.avTimeHB)/sqrt(length(averages.avTimeHB));
    
    simulatedAnnealingTime(i) = mean(averages.avTimeSA);
    simulatedAnnealingTimeErr(i) = std(averages.avTimeSA)/sqrt(length(averages.avTimeSA));
    
    PIMCTime(i) = mean(averages.avTimePIQMC);
    PIMCTimeErr(i) = std(averages.avTimePIQMC)/sqrt(length(averages.avTimePIQMC));
    
end

%% PLOT

n_qubits = 10:5:100;

figure;
hold on 

errorbar(n_qubits, heatBathReps, heatBathRepsErr, 'o');
errorbar(n_qubits, simulatedAnnealingReps, simulatedAnnealingRepsErr, 'o');
errorbar(n_qubits, PIMCReps, PIMCRepsErr, 'o');

legend('Heat Bath', 'Simulated Annealing', 'Path Integral QMC')
title('Average Repetitions')
xlabel('Number of Qubits')
ylabel('Average Reps to $\epsilon$', 'Interpreter', 'LaTeX')
hold off

figure;
hold on 

errorbar(n_qubits, heatBathTime, heatBathTimeErr, 'o');
errorbar(n_qubits, simulatedAnnealingTime, simulatedAnnealingTimeErr, 'o');
errorbar(n_qubits, PIMCTime, PIMCTimeErr, 'o');

legend('Heat Bath', 'Simulated Annealing', 'Path Integral QMC')
title('Average Time')
xlabel('Number of Qubits')
ylabel('Average TT$\epsilon$ /s', 'Interpreter', 'LaTeX')
hold off
