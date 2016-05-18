%Parameters
conn_density = 1;
n_qubits = 10;
disorder = 5;
h_range = [-1,1];
J_range = [-1,1];
initialTemp = 1e25;
tempStep = 1e22;
stepSize = 5;

%Generate couplings 
h = random_coef([n_qubits], 1, h_range, 0, conn_density);
Jzzz  = random_coef( [n_qubits,n_qubits,n_qubits],  1, J_range, 0, conn_density );
Jzzz = symmetrize_3local_couplings(Jzzz);
Jxx  = []; % Couplings turned off
Jzz = []; % Couplings turned off
Jxxx = []; % Couplings turned off
hamParams = {h, Jzz, Jxx, Jzzz, Jxxx};
%Generate Hamiltonian
randHam = ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx);
%Generate starting spin config
spinConfig = generate_spins(n_qubits, disorder);

exact_solution = min(eig(randHam));
sa_solution = simulatedAnnealing(hamParams, spinConfig, initialTemp, tempStep, stepSize);
disp(exact_solution);
disp(sa_solution{1});