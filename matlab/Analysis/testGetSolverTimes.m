getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\2Local\10Qubits', 50, 10, 0.95)

getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\2Local\20Qubits', 50, 10, 0.95)

getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\2Local\30Qubits', 50, 10, 0.95)

getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\2Local\40Qubits', 100, 10, 0.95)

getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\2Local\125Qubits', 100, 10, 0.95)

getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\3Local\10Qubits', 50, 10, 0.95)

getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\3Local\20Qubits', 50, 10, 0.95)

getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\3Local\30Qubits', 100, 10, 0.95)

getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\3Local\40Qubits', 100, 10, 0.95)

getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\3Local\50Qubits', 100, 10, 0.95)

% 
% figure
% scatter(avRepsHB, avRepsPIQMC)
% figure
% scatter(avRepsSA, avRepsPIQMC)
% figure
% scatter(avRepsHB, avRepsSA)
% 
% 
% dat = [avRepsHB, avRepsPIQMC];
% figure
% n = hist3(dat)
% 
% n1 = n';
% n1(size(n,1) + 1, size(n,2) + 1) = 0;
% 
% xb = linspace(min(dat(:,1)),max(dat(:,1)),size(n,1)+1);
% yb = linspace(min(dat(:,2)),max(dat(:,2)),size(n,1)+1);
% 
% h = pcolor(xb,yb,n1);
% 
% % h.ZData = ones(size(n1)) * -max(max(n));
% colormap(jet) % heat map
% title('PIQMC vs HB');
% grid on
% view(2);