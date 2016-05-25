
Ham_1 = load('2016_5_25_7_33_53.571_numqubits_30_numloops_10_TTS_1.8851.mat');
Ham_1 = Ham_1.run_info;
Ham_1_info = Ham_1('ProbSolInfo');
Ham_1_GS = Ham_1_info(3);
Ham_1_mat = Ham_1_info(2);
Hparams = Ham_1_mat{1};
Ham_1_mat;

Spin_config = Ham_1_info(1);
Spin_config{1};

length(Hparams{2});
% Hparams = fliplr(Hparams);

spins = generate_spins(30, 15);


solutionMET = findGroundState('2016_5_25_7_33_53.571_numqubits_30_numloops_10_TTS_1.8851.mat', 'Metropolis', 100, -199, 0.99, 1);
solutionSA = findGroundState('2016_5_25_7_33_53.571_numqubits_30_numloops_10_TTS_1.8851.mat', 'SimulatedAnnealing', 100, -99, 0.99, 0);
solutionPI = findGroundState('2016_5_25_7_33_53.571_numqubits_30_numloops_10_TTS_1.8851.mat', 'PIQMC', 100, -99, 0.99, 0);
solutionINF = infiniteMetropolis(spins, Hparams, 10000, -27, 0.99, 10000);

disp('MET sol is:')
solutionMET{1}
solutionMET{2}
solutionMET{3}

disp('SA sol is:')
solutionSA{1}
solutionSA{2}
solutionSA{3}

disp('PI sol is:')
solutionPI{1}
solutionPI{2}
solutionPI{3}

disp('Inf sol is:')
solutionINF{1}
solutionINF{3}
solutionINF{5}

