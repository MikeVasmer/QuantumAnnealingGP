% data1 = randn(1,1e5);
% data2 = randn(1,1e5)+data1;
% 
% values = hist3([data1(:) data2(:)], [100 100]);
% 
% imagesc(values)


% figure
% scatter(avRepsHB, avRepsPIQMC)
% figure
% scatter(avRepsSA, avRepsPIQMC)
% figure
% scatter(avRepsHB, avRepsSA)


% solution = concAverages()
% 
% avRepsHB = solution{6}
% avRepsPIQMC = solution{3}
% avRepsSA = solution{2}

% percSArand = zeros(length(percSA),1);
% percPIQMCrand = zeros(length(percPIQMC),1);
% percHBrand = zeros(length(percHB),1);
% percSA(end) = 1;
% percPIQMC(end) = 0.5
% 
% for i = 1:length(percSA);
%     x = 1.025 - rand*0.03;
%     y = 1.025 - rand*((1/percSA(i))*0.02);
%     percSArand(i) = percSA(i)*(y^2);
%     percPIQMCrand(i) = percPIQMC(i)*(x^2);
%     
%     percHBrand(i) = percHB(i)*y;
% %     percSArand(i) = percSArand(i)/(max(percSArand));
% %     percPIQMCrand(i) = percPIQMCrand(i)/(max(percPIQMCrand));
% end
    
% percSA23 = cat(1, percSA2(1:300), percSA3);
% percPIQMC23 = cat(1, percPIQMC2(1:300), percPIQMC3);

% percSACh = cat(1, percSAChA, percSAChM)

% percSA3 = sols{9};
% percPIQMC3 = sols{10};
% percPIQMC3(end + 1) = 0;
% percSA3(end + 1) = 1;

scatter(percPIQMC(:), percSA(:))
lims = [0 1 0 1];

% percPIQMC2Planar(end+1) = 0;
% percSA2Planar(end+1) = 0;
axis(lims);
dat = [percPIQMC(:), percSA(:)];
axis square
figure;
x = 0:100;
y = x
n = hist3(dat, [20 20])

n(1, 1) = 138
n1 = n';
n1(size(n,1) + 1, size(n,2) + 1) = 0;

xb = linspace(min(dat(:,1)),max(dat(:,1)),size(n,1)+1);
yb = linspace(min(dat(:,2)),max(dat(:,2)),size(n,1)+1);

% xb = linspace(0,1, size(n,1)+1);
% yb = linspace(0,1, size(n,1)+1);


h = pcolor(xb,yb,n1);
set(h, 'EdgeColor', 'none');

% h.ZData = ones(size(n1)) * -max(max(n));
colormap(flipud(colormap(hot))) % heat map
% colormap(jet)
title('PIQMC vs SA');
xlabel('PIQMC Success Rate')
ylabel('SA Success Rate')
grid on
view(2);