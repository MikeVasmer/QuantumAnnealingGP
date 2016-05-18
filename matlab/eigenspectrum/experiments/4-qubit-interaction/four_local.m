function [] = four_local()

    % Pauli matrices
    sigmaZ = [[1, 0] ;[ 0,-1]];
    
    J_N = 0.25;    % Free
    
    % 4-local Hamiltian
    H_4 = J_N*kron(sigmaZ,kron(sigmaZ,kron(sigmaZ,sigmaZ)));

    % Calculate and plot eigenspectrum between two Hamilontians
    eigenvalues = ...
    eigenspectrum(  transverse_hamiltonian(4),...            % Starting (transverse) Hamiltonian
                    H_4, ...                                 % Finishing (Ising) Hamiltonian
                    51);                                  % Steps

    % Plot eigenspectrum ('2' means both plots)
    plot_eigenspectrum(eigenvalues, 2);
    % Calculate and display minimum gap
    disp(strcat('Minimum gap (4 qubit system):', num2str(minimum_gap(eigenvalues))))

    disp('Eigenvalues of 4 qubit system')
    unique(eig(H_4))'


end

