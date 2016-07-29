% Chain parameters
num_qubits = 12;
field_str = 6.0;

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

% Find indicies of single DW
[vec,val] = eig(ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx));
num_gs = length(find(val==min(diag(val))));
[eig_row,eig_col] = find(vec(:,[1:num_gs]));

% Track single domain wall
steps = 50;
eigvec_indicies = eig_row;
excited_level = 1;

% Show single DW config probs at given s
s = 0.8;
[vec,val] = eig(anneal_hamiltonian( ...
    transverse_hamiltonian(num_qubits), ...
    ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx), ...
    s ));
eig_info(vec,val,excited_level,eigvec_indicies);

% Plot single DW prob over anneal
track_single_DW( ...
    transverse_hamiltonian(num_qubits), ...         % Initial Hamiltonian
    ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx), ... % Finial Hamiltonian
    steps, ...                                      % Steps
    excited_level, ...                              % Excited level
    eigvec_indicies ...                             % Eigenvector indicies to track
);