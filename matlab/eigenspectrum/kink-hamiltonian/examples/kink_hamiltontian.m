% Example Ising coef for n=4 qubits

% Add main directory to path
addpath('../');

% Chain parameters
num_qubits = 10;
field_str = 5.0;

% Array of h coef for local fields
h = zeros(1,num_qubits);
h(1)   =  field_str;
h(end) = -field_str;
% Matrix of J coef for Z-Z, X-X, Z-Z-Z and X-X-X couplings
Jzz  = zeros(num_qubits,num_qubits);
for i = 1:num_qubits
    for j = i+1:num_qubits
        if j == i+1
            Jzz(i,j) = -1;
        end
    end
end
Jxx  = 0; % Couplings turned off
Jzzz = 0; % Couplings turned off
Jxxx = 0; % Couplings turned off

% Calculate and plot eigenspectrum between two Hamilontians
[eigenvectors,eigenvalues] = ...
eigenspectrum(  transverse_hamiltonian(num_qubits),...                   % Starting (transverse) Hamiltonian
                ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx), ... % Finishing (Ising) Hamiltonian
                100);                                            % Steps
            
% Plot eigenspectrum ('2' means both plots)
plot_eigenspectrum(eigenvalues, 2);
% Calculate and display minimum gap
% disp(minimum_gap(eigenvalues));