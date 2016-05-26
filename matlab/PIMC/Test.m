spin = generate_spins(20, 10)
% h = random_coef([100], 1, [0,0], 0, 1)
h = 0
Jzz = NN_couplings(20, 1)
% % spin_2 = transpose(generate_spins(10, 9))
% 
% length(h)
% 
% % fj = [0,1,2,3,4,5,6]
% 
% % [M,A] = min(fj)
% 
% % spin_confs = repmat(spin, 3, 1)
% 
% % x = spin_confs(1)
% %Jzz = random_coef([10,10],  1, [-1,1], 0, 0.5);
% 
Jxx = []
Jzzz = 0
Jxxx = []

HParams = {h, Jzz, Jxx, Jzzz, Jxxx};
% HParams = generate_random_2local_hamiltonian(10,1,[-1,1],[-1,1]);
% eigvals = eig(Ham_10);
% gs_eng = min(eig(Ham_10));
% eigvals(1:100)

% 
% Ham = ising_hamiltonian(h, Jzz, 0, 0, 0);
% 
% Conf_energy(spin, HParams);
% 
% spin_confs = [spin;spin;spin]
% spin_confs_2 = [spin_2;spin_2;spin_2]
% 
% %disp('energy is')
% 
% Ham_d1(spin_confs, HParams, 3, 1, 0.1)
% 
% nums = linspace(0.1,2.1,20)
% 
% tran_prob(spin_confs, spin_confs_2, HParams, 3, 100, 0.1)

% z = arrayfun(@(x) Ham_d1(spin_confs, HParams, 3, 1,x),nums)
% 
% plot(nums, z)
% 
% length(h)

% 
solution = piqmc(spin, HParams, 1000, 20, 1, 0.05, 1);
% solution_2 = piqmcConf(spin, HParams, 100, 20, 1, 0.1, 1);

solution{1}
solution{2}

% 
%answer = solution{2}
% 
% 
% 
% disp(energy)
% energy/99

% plotQHistogram('PIQMC', HParams, 10, 10, 5)

% conf_1 = transpose(conf_1);
% 
% [conf_2, energy_2] = piqmc(conf_1, HParams, 5, 20, 1,0.1, 1)
% 
% disp(energy_2)
% energy/499
% energy_2/499


% gs_eng
% 
% if gs_eng == eng
%     disp('Success')
% else
%     disp('Failure')
% end


