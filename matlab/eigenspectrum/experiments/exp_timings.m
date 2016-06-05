% Experiment: Time scaling for increasing number of qubits

% Add main directory to path
addpath(genpath('../../'));

% repeats = 5;
% max_qubits = 15;
% %times = zeros(1,max_qubits);
% for i = 3:max_qubits
%     tic;
%     for j = 1:repeats
%         disp(sprintf(strcat('Number of Qubits:\t', num2str(i),'\tof\t', num2str(max_qubits), '\tIteration\t', num2str(j), '\tof\t', num2str(repeats))));
%         exp_LAO_eigenspectrum(i);
%     end
%     times(i) = toc/repeats;
% end

close all
fig3 = figure(3);
fig3.Position = [10, 500, 600, 450];
x = [1:1:length(times)]';
%outliers = excludedata(x,times','indices',1:12);

fitFunc = fittype('double_exp(x,a,b,c,d)');

f = fit(x,times',fitFunc, 'StartPoint', [ 0.11, 0.1,1,10]);
xx = 2:0.01:20;
%f = 0.11*(0.000001*exp(0.000016*exp(0.6*(xx+4.9)+1.1)+17)-14);

%f= 0.11*exp(xx-10).^2 + 0.1*exp(xx-10)+1;
%f = spline(x, times, xx)
%plot(f,x,times', 'x')
figure
hold on
%figureHandle = gcf;
%# make all text in the figure to size 14 and bold
%set(findall(figureHandle,'type','text'),'fontSize',30)
semilogy(x, times, 'x')
axis([2 20 1 1000000])

plot(f)

xlabel('Number of qubits, $n$', 'Interpreter', 'LaTeX');
ylabel('Time to Solution, s', 'Interpreter', 'LaTeX');
%legend('Location','northwest');
% annotation('textbox',[.152 .5 .3 .3],'String','f(x)=a*exp(b*x)','FitBoxToText','on');
% annotation('textbox',[.152 .5 .3 .24],'String',strcat('a = ', num2str(f.a)),'FitBoxToText','on');
% annotation('textbox',[.152 .5 .3 .18],'String',strcat('b = ', num2str(f.b)),'FitBoxToText','on');
