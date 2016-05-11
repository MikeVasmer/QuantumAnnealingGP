addpath(genpath('../../'))
clearvars

num_runs = 100;
qs = zeros([num_runs, 1]);
n_qubits = 5;
conn_density = 0.2;
h_range = [-1, 1];
J_range = [-1, 1];
timesteps = 100;
disorder = 1;
T = 1;


H = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);

for run = 1:num_runs
    q = HSimulation(H, n_qubits, disorder, T, timesteps );
    qs(run) = q;
    
end

edges = linspace(-1, 1, 20);
q_histogram = histogram(qs, edges);

