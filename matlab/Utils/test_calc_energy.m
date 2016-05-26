addpath(genpath('../'))

% Array of h coef for local fields
n_qubits = 300;
density = 0.5;
min = 0;
max = 1;
% Random h coef and J coef for Z-Z, X-X, Z-Z-Z and X-X-X couplings
% h    = 0; 
% Jzz  = symmetrize_2local_couplings( random_coef( [n_qubits, n_qubits], 1, [min, max], 0, density ) );
% Jxx  = 0; % Couplings turned off
% Jzzz = symmetrize_3local_couplings( random_coef( [n_qubits, n_qubits, n_qubits], 1, [min, max], 0, density ) );
% Jxxx = 0; % Couplings turned off

hParams = {h,Jzz,Jxx,Jzzz,Jxxx};
spinConfig = generate_spins(n_qubits, randi(n_qubits));

disp(sprintf(strcat('Conf_energy:\t', num2str(Conf_energy( spinConfig, hParams )))));
disp(sprintf(strcat('calc_energy:\t', num2str(calc_energy( spinConfig, hParams )))));