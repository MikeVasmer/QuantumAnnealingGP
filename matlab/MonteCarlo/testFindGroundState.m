

solutionMET = findGroundState('Hparams_test.mat', 'Metropolis', 10, -99, 0.99, 1);
solutionSA = findGroundState('Hparams_test.mat', 'SimulatedAnnealing', 10, -99, 0.99, 1);
solutionPI = findGroundState('Hparams_test.mat', 'PIQMC', 10, -99, 0.99, 1);


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

