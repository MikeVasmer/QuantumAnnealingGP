close all
clearvars
%Navigate to loop-adaptive-optimisation/files/2Local/NN/28May/
folder_2l = uigetdir;
pth_2l = [folder_2l, filesep, 'T2T_Plot_80_qubits.fig'];
nbins = 65;
resolution = 4;

%Open figure produced by TTT analysis and get data
fig_2l = openfig(pth_2l);
title(sprintf('Hardness plot for %d qubits, 2-local interactions',81));
ylabel('Time2Target (seconds)');
pth_2l = [folder_2l, filesep, 'T2T_Plot_81_qubits_2local.fig'];
savefig(pth_2l);
axesObjs_2l = get(fig_2l, 'children');
dataObjs_2l = get(axesObjs_2l, 'children');
xvals_2l = get(dataObjs_2l, 'Xdata');
yvals_2l = get(dataObjs_2l, 'Ydata');
xmax = max(xvals_2l);
xmin = min(xvals_2l);
%Find average TTT using running average defined by resolution
average_TTT = zeros(xmax/resolution,1);
for j=1:(xmax/resolution)
    temp_indeces = [];
    for k=j:(j+resolution);
        indeces_j = find(xvals_2l == j);  
        temp_indeces = [temp_indeces, indeces_j];
    end
    temp_average = 0;
    for i=1:length(temp_indeces)
        temp_average = temp_average + yvals_2l(temp_indeces(i));
    end
    average_TTT(j) = temp_average / length(temp_indeces);
end
%Plot and save
figure(2);
plot(linspace(2.5,xmax,xmax/resolution), average_TTT);
title(sprintf('Average hardness plot for %d qubits, 2-local interactions',81));
xlabel('Iteration');
ylabel('Time2Target (seconds)');
pth_2l = [folder_2l, filesep 'T2T_AveragePlot_81_qubits_2local.fig'];
savefig(2,pth_2l);

%Density plot
hist3data_2l = hist3([xvals_2l',yvals_2l'],[nbins,nbins]);
hist3data_2l_t = hist3data_2l';
hist3data_2l_t(size(hist3data_2l,1) + 1, size(hist3data_2l,2) + 1) = 0;
xbounds_2l = linspace(min(xvals_2l),max(xvals_2l),size(hist3data_2l,1)+1);
ybounds_2l = linspace(min(yvals_2l),max(yvals_2l),size(hist3data_2l,1)+1);
figure(3);
colormap(flipud(colormap('jet')));
%colormap('jet');
%colormap('parula');
plot_2l = pcolor(xbounds_2l, ybounds_2l, hist3data_2l_t);
set(plot_2l,'edgecolor','none')
colorbar
title(sprintf('Hardness density plot for %d qubits, 2-local interactions',81));
xlabel('Iteration');
ylabel('Time2Target (seconds)');
pth_2l = [folder_2l, filesep 'T2T_DensityPlot_81_qubits_2local.fig'];
savefig(3,pth_2l);