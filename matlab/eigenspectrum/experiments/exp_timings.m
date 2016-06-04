% Experiment: Time scaling for increasing number of qubits

% Add main directory to path
addpath(genpath('../../'));

repeats = 5;
max_qubits = 15;
%times = zeros(1,max_qubits);
for i = 3:max_qubits
    tic;
    for j = 1:repeats
        disp(sprintf(strcat('Number of Qubits:\t', num2str(i),'\tof\t', num2str(max_qubits), '\tIteration\t', num2str(j), '\tof\t', num2str(repeats))));
        exp_LAO_eigenspectrum(i);
    end
    times(i) = toc/repeats;
end

close all
fig3 = figure(3);
fig3.Position = [10, 500, 600, 450];
x = [1:1:length(times)]';
f = fit(x,times','exp1');
%plot(f,x,times', 'x')
semilogy(x, temp_times, 'x')
title('Time scaling')
xlabel('Number of qubits, n');
ylabel('Time, s');
legend('Location','northwest')
annotation('textbox',[.152 .5 .3 .3],'String','f(x)=a*exp(b*x)','FitBoxToText','on');
annotation('textbox',[.152 .5 .3 .24],'String',strcat('a = ', num2str(f.a)),'FitBoxToText','on');
annotation('textbox',[.152 .5 .3 .18],'String',strcat('b = ', num2str(f.b)),'FitBoxToText','on');
