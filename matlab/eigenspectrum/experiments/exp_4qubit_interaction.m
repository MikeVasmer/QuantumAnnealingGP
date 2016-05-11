%
h_l = [0,0,0,0];
J_l = 1;
h_a = [0,0,0,0];
J_a = 1;

% No fields
h = [h_l,h_a];
% Fully connected Z-Z couplings
Jzz  = [[0,J_l,J_l,J_l,J_a,J_a,J_a,J_a];...
        [0,  0,J_l,J_l,J_a,J_a,J_a,J_a];...
        [0,  0,  0,J_l,J_a,J_a,J_a,J_a];...
        [0,  0,  0,  0,J_a,J_a,J_a,J_a];...
        [0,  0,  0,  0,  0,  0,  0,  0];...
        [0,  0,  0,  0,  0,  0,  0,  0];...
        [0,  0,  0,  0,  0,  0,  0,  0];...
        [0,  0,  0,  0,  0,  0,  0,  0];...
       ];
Jxx  = 0; % Couplings turned off
Jzzz = 0; % Couplings turned off
Jxxx = 0; % Couplings turned off

% Calculate and plot eigenspectrum between two Hamilontians
eigenvalues = ...
eigenspectrum(  transverse_hamiltonian(8),...                   % Starting (transverse) Hamiltonian
                ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx), ... % Finishing (Ising) Hamiltonian
                51);                                            % Steps
            
% Plot eigenspectrum ('2' means both plots)
plot_eigenspectrum(eigenvalues, 2);
% Calculate and display minimum gap
disp(strcat('Minimum gap (8 qubit system):', num2str(minimum_gap(eigenvalues))))

disp('Eigenvalues of 8 qubit system')
unique(eig(ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx)))'



% 4-qubit interaction Ham
sigmaZ = [[1, 0] ;[ 0,-1]];
H_4 = kron(sigmaZ,kron(sigmaZ,kron(sigmaZ,sigmaZ)));

% Calculate and plot eigenspectrum between two Hamilontians
eigenvalues = ...
eigenspectrum(  transverse_hamiltonian(4),...            % Starting (transverse) Hamiltonian
                H_4, ...                                 % Finishing (Ising) Hamiltonian
                51);                                     % Steps
            
% Plot eigenspectrum ('2' means both plots)
%plot_eigenspectrum(eigenvalues, 2);
% Calculate and display minimum gap
disp(strcat('Minimum gap (4 qubit system):', num2str(minimum_gap(eigenvalues))))

disp('Eigenvalues of 4 qubit system')
unique(eig(H_4))'

