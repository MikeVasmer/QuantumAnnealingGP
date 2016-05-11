% Experiments: Histogram of minimum gaps for rnadom Ising problems

% Add main directory to path
addpath('../');

repeats = 1000;
num_qubits = 6;
minimum_gaps = zeros(1,repeats);
min_gap_range = 0.9;

tic
for i = 1:repeats
   minimum_gaps(i) = exp_eigenspectrum(num_qubits, min_gap_range);
   if toc > 1
       disp(strcat(num2str(i),':', num2str(repeats)))
       tic
   end
end

fig4 = figure(4);
fig4.Position = [10, 500, 600, 450];
hist(minimum_gaps)
title('Minimum gap distribution for random 6-qubit Ising')
xlabel('Energy');
ylabel('Frequency, s');