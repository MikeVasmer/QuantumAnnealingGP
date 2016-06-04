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

percSArand = zeros(length(percSA),1);
percPIQMCrand = zeros(length(percPIQMC),1);
percHBrand = zeros(length(percHB),1);

for i = 1:length(percSA);
    x = 1.025 - rand*0.03;
    y = 1.025 - rand*((1/percSA(i))*0.02);
    percSArand(i) = percSA(i)*(y^2);
    percPIQMCrand(i) = percPIQMC(i)*(x^2);
    percHBrand(i) = percHB(i)*y;
end
    

scatter(percPIQMCrand(:), percSArand(:))

dat = [percPIQMCrand(:), percSArand(:)];
figure
n = hist3(dat, [50 50])

n1 = n';
n1(size(n,1) + 1, size(n,2) + 1) = 0;

% xb = linspace(min(dat(:,1)),max(dat(:,1)),size(n,1)+1);
% yb = linspace(min(dat(:,2)),max(dat(:,2)),size(n,1)+1);

xb = linspace(0,1, size(n,1)+1);
yb = linspace(0,1, size(n,1)+1);


h = pcolor(xb,yb,n1);
set(h, 'EdgeColor', 'none');

% h.ZData = ones(size(n1)) * -max(max(n));
colormap(flipud(colormap(jet))) % heat map
colormap(jet)
title('PIQMC vs SA');
grid on
view(2);