addpath(genpath('../../'))
clearvars

num_runs = 100;
qs = zeros([num_runs, 1]);
n_qubits = 5;
conn_density = 0.5;
h_range = [-1, 1];
J_range = [-1, 1];
timesteps = 100;
disorder = round(n_qubits / 2);
T = 0.1;


H = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);

% Sanity check
%H = ising_hamiltonian([-500,-500,-500,-500,-500], 0, 0, 0, 0);

for run = 1:num_runs
    q = HSimulation(H, n_qubits, disorder, T, timesteps );
    qs(run) = q;
    
end

% Plot

edges = linspace(-1, 1, 50);
q_histogram = histogram(qs, edges, 'Normalization', 'probability');
xlabel('q')
ylabel('P(q)')

