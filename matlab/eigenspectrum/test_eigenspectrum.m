% Array of h coef for local fields
h=[1,0.5,0.8,1];
% Matrix of J coef for couplings
J=[[0,1,0,0];[1,0,0,0];[1,1,0,0];[1,0,1,0]];

% Calculate and plot eigenspectrum between two Hamilontians
eigenspectrum(  transverse_hamiltonian(4),...   % Starting Hamiltonian
                ising_hamiltonian(h, J), ...    % Finishing Hamiltonian
                21, ...                         % Steps
                2);                             % Optional: figures to plot