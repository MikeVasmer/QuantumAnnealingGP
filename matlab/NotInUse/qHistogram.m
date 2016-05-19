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
beta = 10000;


[H, Hparams] = generate_random_3local_hamiltonian(n_qubits, conn_density, h_range, J_range);

% Sanity check
%[H, h, Jzz, Jxx, Jzzz, Jxxx] = ising_hamiltonian([-500,-500,-500,-500,-500], 0, 0, 0, 0);

tic
for run = 1:num_runs
    solution = HSimulation(H, Hparams, n_qubits, disorder, beta, timesteps, 'HeatBath');
    q = solution{1};
    qs(run) = q;
    if toc > 1
       disp(strcat(num2str(run),':', num2str(num_runs)))
       tic
    end
end

% Plot

edges = linspace(-1, 1, 50);
q_histogram = histogram(qs, edges, 'Normalization', 'probability');
xlabel('q')
ylabel('P(q)')

