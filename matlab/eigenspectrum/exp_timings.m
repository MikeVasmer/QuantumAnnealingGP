
repeats = 1;
max_qubits = 12;
times = zeros(1,max_qubits);
for i = 1:max_qubits
    tic;
    for j = 1:repeats
       exp_eigenspectrum(i) 
    end
    times(i) = toc/repeats;
end

close all
fig3 = figure(3);
fig3.Position = [10, 500, 600, 450];
x = [1:1:length(times)]';
f = fit(x,times','exp1');
plot(f,x,times', 'x')
title('Time scaling')
xlabel('Number of qubits, n');
ylabel('Time, s');
legend('Location','northwest')
annotation('textbox',[.152 .5 .3 .3],'String','f(x)=a*exp(b*x)','FitBoxToText','on');
annotation('textbox',[.152 .5 .3 .24],'String',strcat('a = ', num2str(f.a)),'FitBoxToText','on');
annotation('textbox',[.152 .5 .3 .18],'String',strcat('b = ', num2str(f.b)),'FitBoxToText','on');
