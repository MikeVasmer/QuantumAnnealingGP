

% getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\2Local\NN\28May', 100, 15, 0.95)
% getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\3Local\NN', 100, 15, 0.95)
% getSolverTimes('C:\Users\dwise\UCL\QuantumAnnealingGP\matlab\loop-adaptive-optimisation\files\2Local\30Qubits', 50, 10, 0.95)

percFindGroundState('2016_5_29_6_24_26.688_numqubits_81_numloops_162_TTS_6.9448.mat', 'PIQMC', 1, 0, 0.9, 0)

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