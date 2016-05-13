spin = generate_spins(20, 20)
h = random_coef([20], 1, [0,0], 0, 1)
% spin_2 = transpose(generate_spins(10, 9))

length(h)

% fj = [0,1,2,3,4,5,6]

% [M,A] = min(fj)

% spin_confs = repmat(spin, 3, 1)

% x = spin_confs(1)
Jzz = random_coef( [20,20],  1, [1,1], 0, 1)
Jxx = 0
Jzzz = 0
Jxxx = 0

HParams = {h, Jzz, Jxx, Jzzz, Jxxx}
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


piqmc(spin, HParams, 20, 10, 10, 20, 1)

