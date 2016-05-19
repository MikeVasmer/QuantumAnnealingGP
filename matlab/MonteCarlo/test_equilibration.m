clearvars
close all

% Metropolis Params
beta_M = 10000;
timesteps_M = 1000;
num_flips_M = 1;
Gamma_M = 1;

%Hamiltonian
n_qubits = 200;
conn_density = 0.5;
h_range = [-1, 1];
J_range = [-1, 1];
disorder = round(n_qubits / 2);
Hparams = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);
%Hparams = {0, NN_couplings(n_qubits, 1), 0, 0, 0};

%Spins
spins1 = generate_spins(n_qubits, disorder);
spins2 = generate_spins(n_qubits, disorder);

%Order parameter list init
qList = zeros(timesteps_M, 1);

tic;
for time=1:timesteps_M
    spins1 = Metropolis(spins1, Hparams, beta_M, 1, num_flips_M, Gamma_M);
    spins2 = Metropolis(spins2, Hparams, beta_M, 1, num_flips_M, Gamma_M);
    qList(time) = dot(spins1, spins2)/n_qubits;
     if toc > 1
       disp(strcat(num2str(time),':', num2str(timesteps_M)));
       tic;
    end
end

%Plot
times = linspace(1, timesteps_M, timesteps_M);
plot(times, qList);

