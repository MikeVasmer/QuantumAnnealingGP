% Array of h coef for local fields
n_qubits = 3;
density = 0.5;
min = 0;
max = 1;
% Random h coef and J coef for Z-Z, X-X, Z-Z-Z and X-X-X couplings
h    = 0; 
Jzz  = symmetrize_2local_couplings( random_coef( [n_qubits, n_qubits], 1, [min, max], 0, density ) );
Jxx  = 0; % Couplings turned off
randcoeffs = random_coef( [n_qubits, n_qubits, n_qubits], 1, [min, max], 0, density );
Jzzz = symmetrize_3local_couplings( randcoeffs )
Jxxx = 0; % Couplings turned off

testJzzz = symmetrize3local(randcoeffs)

isequal(Jzzz, testJzzz)