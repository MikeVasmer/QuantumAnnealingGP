function [out] = four_local()

    % Add main directory to path
    addpath('../../');

    % Pauli matrices
    sigmaZ = [[1, 0] ;[ 0,-1]];
    
    J_N = 1;    % Free
    
    % 4-local Hamiltian
    H_3 = J_N*kron(sigmaZ,kron(sigmaZ,sigmaZ));

    % Calculate and plot eigenspectrum between two Hamilontians
    eigenvalues = ...
    eigenspectrum(  transverse_hamiltonian(3),...            % Starting (transverse) Hamiltonian
                    H_3, ...                                 % Finishing (Ising) Hamiltonian
                    51);                                  % Steps

    % Plot eigenspectrum ('2' means both plots)
    plot_eigenspectrum(eigenvalues, 2);
    % Calculate and display minimum gap
    disp(strcat('Minimum gap (3 qubit system):', num2str(minimum_gap(eigenvalues))))

    disp('Eigenvalues of 3 qubit system')
    out = eig(H_3);

end

