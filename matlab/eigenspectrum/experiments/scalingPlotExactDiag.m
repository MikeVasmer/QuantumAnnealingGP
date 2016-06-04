load('timings.mat')

num_qubits = 1:15;
plot(num_qubits, times, '-o')