%f = @() exp_eigenspectrum(4);
%timeit(f)

max_qubits = 12;
repeats = 1;

times = zeros(1,max_qubits);
for i = 1:max_qubits
    tic;
    for j = 1:repeats
        exp_eigenspectrum(i);
    end
    times(i) = toc/repeats;
end

fig3 = figure(3);
fig3.Position = [10, 500, 600, 450];
plot(times);
title('Time scaling')
xlabel('Number of qubits, n');
ylabel('Time, s');