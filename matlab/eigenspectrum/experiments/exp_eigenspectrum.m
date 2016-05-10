function [] = exp_eigenspectrum(n_qubits)

% Example random Ising coef for n=4 qubits
% Array of h coef for local fields
%n_qubits = 8;
conn_density = 0.5;
min = 0;
max = 1;
% Random h coef
h = random_coef( [n_qubits], min, max, conn_density );
% Random J coef for Z-Z, X-X, Z-Z-Z and X-X-X couplings
Jzz  = random_coef( [n_qubits,n_qubits], min, max, conn_density );
Jxx  = 0; % Couplings turned off
Jzzz = 0; % Couplings turned off
Jxxx = 0; % Couplings turned off

% Calculate and plot eigenspectrum between two Hamilontians
eigenvalues = ...
eigenspectrum(  transverse_hamiltonian(n_qubits),...            % Starting (transverse) Hamiltonian
                ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx), ... % Finishing (Ising) Hamiltonian
                21);                                            % Steps
            
% Plot eigenspectrum ('2' means both plots)
% plot_eigenspectrum(eigenvalues, 2);
% Calculate and display minimum gap
% disp(minimum_gap(eigenvalues));

end