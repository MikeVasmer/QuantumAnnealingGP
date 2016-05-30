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


solution = concAverages()

avRepsHB = solution{6}
avRepsPIQMC = solution{3}
avRepsSA = solution{2}

scatter(avRepsSA(:), avRepsHB(:))

dat = [avRepsHB, avRepsSA];
figure
n = hist3(dat, [50 50])

n1 = n';
n1(size(n,1) + 1, size(n,2) + 1) = 0;

xb = linspace(min(dat(:,1)),max(dat(:,1)),size(n,1)+1);
yb = linspace(min(dat(:,2)),max(dat(:,2)),size(n,1)+1);

h = pcolor(xb,yb,n1);

% h.ZData = ones(size(n1)) * -max(max(n));
colormap(jet) % heat map
title('PIQMC vs HB');
grid on
view(2);