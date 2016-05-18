function [out] = two_local()

    % Add main directory to path
    addpath('../../');

    % h's and J's
    % Require that:
    %     |J_N| << J_a
    %     |J_N| < q_0 << J_a 
    %     0 < q_i < J_a
    %     |J_N| < q_0 << J_a
    % H_N = J_N Z_1*Z_2*Z_3*Z_4 
    N = 4;      % Fixed

   % Require: |J_N| < q_0 << J_a
    J_N = 1;    % Free
    q_0 = 2;    % Free
    J_a = 4;    % Free

    h_a = zeros(1,N);
    for i = 1:N
        h_a(i) = -J_a*(2*i-N) + q_i(N, i, J_N, q_0);
    end
    J_l =  J_a;
    h_l = -J_a + q_0;

    % No fields
    h = [[h_l,h_l,h_l,h_l],h_a];
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
    sub_out = eig(ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx));
    out = sort(sub_out - min(sub_out) - J_N, 'descend');

end

