%Parameters
conn_density = 1;
n_qubits = 30;
h_range = [-1,1];
J_range = [-1,1];
initialTemp = 1e25;
tempStep = 1e22;
iterations = 10;

%Generate couplings 
h = random_coef([n_qubits], 1, h_range, 0, conn_density);
%disp(h);
Jzzz  = random_coef( [n_qubits,n_qubits,n_qubits],  1, J_range, 0, conn_density );
Jzzz = symmetrize_3local_couplings(Jzzz);
Jxx  = []; % Couplings turned off
Jzz = []; % Couplings turned off
Jxxx = []; % Couplings turned off

%randHam = ising_hamiltonian(h, Jzz, Jxx, Jzzz, Jxxx);
randHam = [];
Hparams = {h, Jzz, Jxx, Jzzz, Jxxx};

fast = true;
simulatedAnnealing(randHam, Hparams, initialTemp,...
    tempStep, iterations, fast, n_qubits)
%fast = false;
%simulatedAnnealing(randHam, Hparams, initialTemp,...
%    tempStep, iterations, fast, n_qubits)