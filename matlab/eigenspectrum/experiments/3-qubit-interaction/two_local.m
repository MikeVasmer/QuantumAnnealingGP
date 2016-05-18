function [] = two_local( J_a, steps )

    h_a = 1;
    J_l = J_a/2;
    h_l = h_a/2;

    % No fields
    h = [[h_l,h_l,h_l],h_a];
    % Fully connected Z-Z couplings
    Jzz  = [[0,    J_l,  J_l,  J_a ];...
            [0,    0,    J_l,  J_a ];...
            [0,    0,    0,    J_a ];...
            [0,    0,    0,    0   ];...
           ];
    Jxx  = 0; % Couplings turned off
    Jzzz = 0; % Couplings turned off
    Jxxx = 0; % Couplings turned off

    % Calculate and plot eigenspectrum between two Hamilontians
    eigenvalues = ...
    eigenspectrum(  transverse_hamiltonian(4),...                   % Starting (transverse) Hamiltonian
                    ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx), ... % Finishing (Ising) Hamiltonian
                    steps);                                         % Steps

    % Plot eigenspectrum ('2' means both plots)
    plot_eigenspectrum(eigenvalues, 2);
    % Calculate and display minimum gap
    disp(strcat('Minimum gap (8 qubit system):', num2str(minimum_gap(eigenvalues))))

    disp('Eigenvalues of 8 qubit system')
    unique(eig(ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx)))'

end

