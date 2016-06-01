%One time script to combine scatter plots generated with TTT_analysis

close all
clearvars

pth_3l = '/home/mikevasmer/Dropbox/MRes/GroupProject/QuantumAnnealingGP/matlab/loop-adaptive-optimisation/files/3Local/NN/81Qubits';
pth_AM = strcat(pth_3l,'/Alex/T2T_Plot_81_qubits.fig');
pth_DD = strcat(pth_3l,'/Dan/T2T_Plot_81_qubits.fig');
pth_DW = strcat(pth_3l,'/David/T2T_Plot_81_qubits.fig');
pth_MV = strcat(pth_3l,'/Mike/T2T_Plot_81_qubits.fig');

xvals_3l = [];
yvals_3l = [];
pth_cell = {pth_AM, pth_DD, pth_DW, pth_MV};
for i=1:4
    fig = openfig(pth_cell{i});
    axes = get(fig, 'children');
    data = get(axes, 'children');
    xvals_3l = [xvals_3l, get(data, 'Xdata')];
    yvals_3l = [yvals_3l, get(data, 'Ydata')];
end
%disp(max(xvals_3l));

figure(5);
s2 = scatter(xvals_3l, yvals_3l);
title(sprintf('Hardness for %d qubits, 3-local interactions', 81));
xlabel('Iteration');
ylabel('Time2Target (seconds)');
s2.LineWidth = 0.6;
s2.MarkerEdgeColor = 'r';
s2.MarkerFaceColor = 'r';
savefig(5, strcat(pth_3l,'/T2T_Plot_81_qubits_3local_AllData.fig'));

